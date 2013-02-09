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
    puts "========\n" + self.class.name + "##{__method__}" + "\n========\n"

    if options.is_a?(Hash)
      if options[:replace]
        remove_player(player.id)
      end
      if options[:overwrite_id]
        player.id = SecureRandom.uuid
      end
    end
    register_player(player)

    puts "========\n" + self.class.name + "##{__method__}" + "\n========\n"
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
    Array.new(@players.to_a)
  end

  def get_player_states
    puts "========\n" + self.class.name + "##{__method__}" + "\n========\n"
    puts 'players'
    puts @players.inspect
    states = []
    @players.each do |player|
      states.push player.get_state
    end

    puts "========\n" + self.class.name + "##{__method__}" + "\n========\n"

    return states

  end

  private

  def register_player(player)
    puts "========\n" + self.class.name + "##{__method__}" + "\n========\n"
    puts 'player'
    puts player.inspect
    puts @players.inspect
    if !@player_lookup[player.id]
      # if player.id == nil
      #   player.set_id(SecureRandom.uuid)
      # end
      @player_lookup[player.id] = player
      @players.add(player)
    end

    puts "========\n" + self.class.name + "##{__method__}" + "\n========\n"
  end

end

