class PlayerManager

  def initialize
    @player_lookup = {}
    @players = Set.new
  end

  def reset
    @player_lookup.clear
    @players.clear
  end

  def add_player(player, options=nil)

    if options.is_a?(Hash)
      if options[:replace]
        remove_player(player.id)
      end
      if options[:overwrite_id]
        player.id = SecureRandom.uuid
      end
    end
    register_player(player)

  end

  def remove_player(player)
    case player
    when String
      id = player
    else
      id = player.id
    end

    player = @player_lookup.delete(id)
    @players.delete(player)
  end

  def get_player(id)
    @player_lookup[id]
  end

  def get_all_players
    Array.new(@players.to_a)
  end

  def get_all_players_with_pieces
    matched_players = []
    @players.each do |player|

      if player.has_pieces?
        matched_players.push(player)
      end

    end
    return matched_players
  end

  def get_player_states
    # puts 'Getting player states:'
    # puts @players.inspect
    states = []
    @players.each do |player|
      states.push player.get_state
    end


    return states

  end

  private

  def register_player(player)
    # puts 'Registering player:'
    # puts player.inspect
    # puts @players.inspect
    if @player_lookup[player.id]
      return nil
    else
      @player_lookup[player.id] = player
      @players.add(player)
      return player
    end
  end

end

