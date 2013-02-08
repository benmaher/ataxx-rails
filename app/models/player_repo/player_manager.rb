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
        player.id = nil
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

    player = @players_lookup.remove(id)
    @players.remove(player)
  end

  def get_player(id)
    @player_lookup[id]
  end

  def get_all_players
    Array.new(@players)
  end

  def get_player_states
    puts "========\n" + self.class.name + "##{__method__}" + "\n========\n"

    states = []
    @players.each do |player|
      states.push player.get_state
    end

    puts "========\n" + self.class.name + "##{__method__}" + "\n========\n"

    return states

  end

  private

  def register_player(player)
    if !@player_lookup[player.id]
      if player.id == nil
        player.set_id(SecureRandom.uuid)
      end
      @player_lookup[player.id] = player
    end
  end

end

