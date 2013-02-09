# require './models/game_grid_model.rb'
# require './models/game_piece_model.rb'
# require './models/grid_point_model.rb'
# require './models/player_model.rb'
# require './views/game_grid_view.rb'


class GameStateModel

  attr_reader :game_grid_model

  STATE_UNINITIALIZED = 6
  STATE_START_TURN = 0
  STATE_SELECT_PIECE = 1
  STATE_MOVE_PIECE = 2
  STATE_END_TURN = 3
  STATE_RUNNING = 4
  STATE_FINISHED = 5

  def initialize


    reset

    @logo_lookup = { 1 => :X, 2 => :O, 3 => :Y, 4 => :P}

    @piece_manager = PieceManager.new
    @player_manager = PlayerManager.new

    # @game_grid_model.unoccupied_locations.each do |location|
    #   add_new_player_piece(1, location)
    # end

    # remove_player_piece(@game_grid_model.get_game_piece("g6"))

  end

  def reset
    @game_state = STATE_UNINITIALIZED
    @selected_pieces = []
    @current_player_id = nil
    @player_order = []
    @player_position = nil
    @available_moves = []
    @current_player = nil
    @current_player_piece = nil
  end

  def attach_board(board)
    @game_grid_model = board
    @game_grid_view = GameGridView.new(@game_grid_model)
  end

  def setup(data)
    puts "========\n" + self.class.name + "##{__method__}" + "\n========\n"

    puts 'data'
    puts data.inspect

    data[:players].each_with_index do |player_data, index|
      player = PlayerModel.new
      player.set_logo(@logo_lookup[index+1])
      @player_manager.add_player(player)
      @player_order.push(player.id)
      player_data[:initial_locations].each do |location|
        add_new_player_piece(player.id, location)
      end
    end

    validate_state

    puts 'state'
    puts get_state.inspect

      # -- Setup player pieces
      # x_size = @game_grid_model.x_size
      # y_size = @game_grid_model.y_size

      # add_new_player_piece(1, GridPointModel.new(x_size-1, y_size-1))
      # add_new_player_piece(2, GridPointModel.new(y_size-1, 0))
      # add_new_player_piece(2, GridPointModel.new(0, y_size-1))


    puts "========\n" + self.class.name + "##{__method__}" + "\n========\n"
  end

  def load_state(state)

    if state == nil
      reset

      # -- Setup players.
      # @players = { 1 => PlayerModel.new(1, :X), 2 => PlayerModel.new(2, :O) }

      @game_state = STATE_SELECT_PIECE

    else
      @game_state = state[:state_code]

      load_players_from_state(state[:players])

      load_pieces_from_state(state[:pieces][:all])
      @selected_pieces = Array.new(state[:pieces][:selected])

      @player_order = Array.new(state[:player_order])
      turn_player_id = state[:turn_player_id]
      @current_player_id = turn_player_id == nil ? @player_order.first : turn_player_id
      @player_position = @player_order.index(@current_player_id)
      @current_player = @player_manager.get_player(@current_player_id)
      @current_player_piece = nil
    end

    @game_running = true
    validate_state
  end

  def get_state
    puts "========\n" + self.class.name + "##{__method__}" + "\n========\n"

    {
      :state_code => @state_code,
      :players => @player_manager.get_player_states,
      :pieces => {
        all: @piece_manager.get_piece_states,
        selected: @selected_pieces
      },
      :turn_player_id => @current_player_id,
      :player_order => @player_order
    }

  end



  def load_players_from_state(state)
    @player_manager.reset
    state.each do |player_state|
      @player_manager.add_player(PlayerModel.new.load_state(player_state))
    end
  end

  def load_pieces_from_state(state)
    @pieces = {}
    state.each do |piece_state|
      add_new_player_piece(piece_state[:id], piece_state[:player_id])
    end
  end

  def get_all_player_stats
    stats = {}
    @players.each do |player_id, player|
      stats[player_id] = {
        :piece_count => player.game_pieces.count
      }
    end
    return stats
  end

  def get_board_state_stats
    {
      :pieces => get_all_piece_state_stats,
      :size => [@game_grid_model.x_size, @game_grid_model.y_size],
      :selected_pieces => @selected_pieces,
      :available_moves => @available_moves
    }
  end

  def get_all_piece_state_stats
    states = []
    @players.each do |player_id, player|
      player.game_pieces.each do |piece|
        states.push({
          :player_id => player_id,
          :location_id => piece.location_id
          })
      end
    end
    return states
  end

  def end_player_turn


    if has_game_ended?
      # -- Game has ended.

      @game_running = false

      # -- Draw final board.
      redraw_board(@message)

      # -- Handle winner or draw.
      if @winner == nil
        @message = "Result: The game is a draw."
      else
        @message = "Result: Player #{@winner.logo} wins!"
      end
      @message += "<br>GAME OVER"

    else
      # -- Game still running.

      advance_to_next_player

      # -- Set status message.
      @message = nil


    end
  end

  def validate_state
    if @current_player_id == nil
      @player_position = -1;
    else
      @player_position = @player_order.index(@current_player_id)
    end
  end

  def advance_to_next_player
    validate_current_player

    # -- Switch to next player.
    @player_position += 1
    @player_position = @player_position >= @player_order.length ? 0 : @player_position
    # -- Select next player.
    @current_player_id = @player_order[@player_position]
    @current_player = @player_manager.get_player(@current_player_id)
    @game_state = STATE_SELECT_PIECE
  end

  def handle_update(update_info)

    response = {}
    @message = nil
    state = nil
    puts "hello"
    # puts @game_state.inspect

    case @game_state

    when STATE_SELECT_PIECE
      response[:game_state] = @game_state

      # -- Draw game board and message.
      redraw_board(@message)

      # -- Get player selection.
      # print "Move which piece?: "
      # piece_location = gets.strip
      piece_location = update_info[:location_id]
      puts "Clicked location: #{piece_location}"
      # -- Attempt to get player piece at that location.
      @current_player_piece = get_player_piece(@current_player_id, piece_location)

      if @current_player_piece == nil
        # -- Invalid piece selection.
        @message = "\"#{piece_location}\" is not a valid selection."
      else
        @message = "Selected piece at location: #{piece_location}"

        # -- Valid piece selection.
        # -- Update game grid with possible moves for selected piece.
        @available_moves = @current_player_piece.available_moves
        puts @available_moves.inspect
        @game_grid_model.set_target_locations(@current_player_piece.available_moves)
        # -- Set status message.
        @message = nil
        # -- Transition to next game state.
        @game_state = STATE_MOVE_PIECE


        redraw_board(@message)

        @selected_pieces.push({
          :player_id => @current_player_id,
          :location_id => @current_player_piece.location_id
          })
      end


    when STATE_MOVE_PIECE
      # -- Draw game board and message.
      redraw_board(@message)

      # -- Get player move.
      # print "Move \"#{piece_location}\" to where?: "
      # piece_destintation = gets.strip
      piece_destintation = update_info[:location_id]
      puts "Clicked location: #{piece_destintation}"

      if @current_player_piece.allowed_move?(piece_destintation) &&
        !@game_grid_model.occupied_location?(piece_destintation)
        # -- Move is allowed by piece and destination is not occupied.

        # -- Get destination grid point.
        piece_destination_grid_point = @game_grid_model.get_location_grid_point(piece_destintation)

        if (@current_player_piece.location_grid_point.x - piece_destination_grid_point.x).abs > 1 ||
          (@current_player_piece.location_grid_point.y - piece_destination_grid_point.y).abs > 1
          # -- Movement is more than one space.

          # -- Piece jumps instead of duplicating.
          remove_player_piece(@current_player_piece)
        end

        # -- Add new piece.
        @attacking_player_piece = add_new_player_piece(@current_player_id, piece_destintation)
        # -- Assmiilate adjacent opponent pieces.
        assimilate_adjacent_enemies(@attacking_player_piece)

        # -- Clear possible moves from game grid.
        @available_moves = []
        @game_grid_model.set_target_locations(nil)

        end_player_turn()

        redraw_board(@message)

        @selected_pieces.clear
      else
        # -- Move is not allowed by piece or destination is occupied.
        puts "location: " + @current_player_piece.location_id
        puts "destination: " + @game_grid_model.resolve_location(piece_destintation)
        if @game_grid_model.resolve_location(piece_destintation) == @current_player_piece.location_id
          # -- No destination entered.

          # -- Clear possible moves from game grid.
          @available_moves = []
          @game_grid_model.set_target_locations(nil)

          # -- Set status message.
          @message = "Deselected \"#{piece_location}\"."
          # -- Transition to previous game state.
          @game_state = STATE_SELECT_PIECE

          redraw_board(@message)

          @selected_pieces.clear

        else
          # -- Invalid destination entered.
          @message = "\"#{piece_destintation}\" is not a valid move."
        end
      end
    end
  end

  def has_game_ended?

    # -- Find all players that still have pieces.
    players_with_pieces = []
    @players.each do |player_id, player|

      if player.has_pieces?
        players_with_pieces.push(player)
      end

    end


    if players_with_pieces.length == 1
      # -- Only one player has pieces.

      # -- Set winner and indicate game end.
      @winner = players_with_pieces[0]
      return true
    end


    # -- Find all players that still have moves.
    players_with_moves = []
    @players.each do |player_id, player|

      if player.has_moves?
        players_with_moves.push(player)
      end

    end

    if players_with_moves.length == 1
      # -- Only one player has moves.

      # -- Fill rest of board with this player's pieces
      @game_grid_model.unoccupied_locations.each do |location|
        player_id = players_with_moves[0].player_id
        add_new_player_piece(player_id, location)
      end
      # -- Update that no players have moves.
      players_with_moves.clear
    end

    if players_with_moves.length == 0
      # -- No players have moves.

      # -- Determine which player has the most pieces.
      most_pieces = 0
      players_with_most = []
      @players.each do |player_id, player|
        # puts "#{player_id} : #{player.get_piece_count}"
        if player.get_piece_count >= most_pieces
          if player.get_piece_count > most_pieces
            players_with_most.clear
          end
          players_with_most.push(player)
          most_pieces = player.get_piece_count
          # puts "ADDING PLAYER"
        end
      end

      if players_with_most.length == 1
        # -- Only one player has the most pieces.

        # -- Set winner and indicate game end.
        @winner = players_with_most[0]
      end
      # -- Game has ended.
      return true
    end

    # -- Game has not ended.
    return false
  end

  def redraw_board(message)
    # system ("clear")
    @game_grid_view.display_grid

    puts

    @player_manager.get_all_players.each do |player|
      puts "Player #{player.logo} piece count: #{player.get_piece_count}"
    end

    puts
    if message == nil
      puts "Turn: Player #{@current_player.logo}"
    else
      puts "Turn: Player #{@current_player.logo} - Status: #{message}"
    end

    puts
  end

  def get_player_piece(player_id, location)
    game_piece = @game_grid_model.get_game_piece(location)

    if game_piece != nil && game_piece.player_id == player_id
      # -- Game piece exists for player at given location.
      return game_piece
    else
      # -- Game piece does not exist for player at given location.
      return nil
    end
  end

  def assimilate_adjacent_enemies(attacking_player_piece)

    if !attacking_player_piece.is_a?(GamePieceModel)
      # -- Do nothing if piece is wrong class.
      return nil
    end

    # -- Create ranges for adjacent cells.
    x_start = attacking_player_piece.location_grid_point.x - 1
    x_end = attacking_player_piece.location_grid_point.x + 1
    y_start = attacking_player_piece.location_grid_point.y - 1
    y_end = attacking_player_piece.location_grid_point.y + 1

    # puts "Attacking piece: " + attacking_player_piece.location_id

    x_start.upto(x_end) do |x_coor|
      y_start.upto(y_end) do |y_coor|
        target_player_piece = @game_grid_model.get_game_piece(GridPointModel.new(x_coor, y_coor))
        if target_player_piece != nil &&
          target_player_piece.player_id != attacking_player_piece.player_id
          # -- Opponent piece exists in adjacent cell.

          # puts "Target piece: " + target_player_piece.location_id

          target_location = target_player_piece.location_id

          # -- Remove opponent piece to adjacent cell.
          remove_player_piece(target_player_piece)
          # -- Add attacking piece to adjacent cell.
          add_new_player_piece(attacking_player_piece.player_id, target_location)
        end
      end
    end

    # puts "Assimiation complete."
    # gets
  end

  def add_new_player_piece(player_id, location)
    # -- Create new player piece for given player_id.
    player = @player_manager.get_player(player_id)
    piece = GamePieceModel.new(player_id, player.logo)
    if @game_grid_model.add_piece(piece.id, location)
      # -- Unable to place piece on board.
      return false
    else
      # -- Piece placed on board.

      # -- Update available moves.
      update_available_moves_for_pieces
      # -- Register piece with player.
      player.add_game_piece(piece.id)
      piece.set_location(location)
      # -- Return.
      return true
    end
  end

  def remove_player_piece(piece)
    # -- Remove piece from board.
    @game_grid_model.remove_piece(piece)
    # -- Remove piece from manager.
    @piece_manager.remove_piece(piece)
    # -- Remove piece from player.
    @player_manager.get_player(player_piece.player_id).remove_game_piece(piece)

    game_piece.remove_location
    update_available_moves_for_pieces
  end

end

