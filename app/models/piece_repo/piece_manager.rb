class PieceManager

  def initialize
    @piece_lookup = {}
    @pieces = Set.new
  end

  def reset
    @piece_lookup.clear
    @pieces.clear
  end

  def add_piece(piece, options=nil)
    if options.is_a?(Hash)
      if options[:replace]
        remove_piece(piece.id)
      end
      if options[:overwrite_id]
        piece.id = SecureRandom.uuid
      end
    end
    register_piece(piece)
  end

  def remove_piece(piece)
    # puts
    # puts piece.inspect
    # puts @pieces_lookup.inspect
    # puts @pieces.inspect

    case piece
    when String
      id = piece
    else
      id = piece.id
    end

    piece = @piece_lookup.delete(id)
    @pieces.delete(piece)
  end

  def get_piece(id)
    @piece_lookup[id]
  end

  def get_all_pieces
    Array.new(@pieces)
  end

  def get_all_pieces_with_moves
    matched_pieces = []
    @pieces.each do |piece|

      if piece.has_moves?
        matched_pieces.push(piece)
      end

    end
    return matched_pieces
  end

  def get_all_players_with_moves
    pieces = get_all_pieces_with_moves
    matched_players = Set.new
    pieces.each do |piece|
      matched_players.add(piece.player_id)
    end
    return matched_players
  end

  def get_piece_states

    states = []
    @pieces.each do |piece|
      states.push piece.get_state
    end

    return states

  end

  def update_available_moves(board)
    @pieces.each do |piece|
      piece.update_available_moves(board)
    end
  end

  private

  def register_piece(piece)
    if @piece_lookup[piece.id]
      return nil
    else
      @piece_lookup[piece.id] = piece
      @pieces.add(piece)
      return piece
    end
  end



end

