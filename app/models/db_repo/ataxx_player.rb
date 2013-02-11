class AtaxxPlayer < ActiveRecord::Base
  attr_accessible :ataxx_session_id, :number, :user_id


  attr_reader :logo
  attr_reader :game_pieces

  def initialize(number=nil, logo=nil)
    @id = SecureRandom.uuid
    @number = number
    @logo = logo
    @game_pieces = Set.new
  end

  def set_id(id)
    @id = id
  end

  def set_logo(logo)
    @logo = logo
  end

  def get_state
    {
      id: @id,
      number: @number,
      logo: @logo
    }
  end

  def load_state(state)
    @id = state[:id]
    @number = state[:number]
    @logo = state[:logo]
    @game_pieces = Set.new state[:pieces]
    return self
  end

  def add_game_piece(game_piece_id)
    @game_pieces.add(game_piece_id)
  end

  def remove_game_piece(game_piece_id)
    @game_pieces.delete(game_piece_id)
  end

  def get_piece_count
    return @game_pieces.length
  end

  def has_pieces?
    return @game_pieces.length > 0
  end

  # def has_moves?
  #   @game_pieces.each do |game_piece|
  #     if game_piece.available_moves.length != 0
  #       return true
  #     end
  #   end
  #   return false
  # end

end
