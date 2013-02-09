class PieceManager

  def initialize
    @piece_lookup = {}
    @pieces = Set.new
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
    case piece
    when String
      id = piece
    else
      id = piece.id
    end

    piece = @pieces_lookup.remove(id)
    @pieces.remove(piece)
  end

  def get_piece(id)
    @piece_lookup[id]
  end

  def get_all_pieces
    Array.new(@pieces)
  end

  def get_piece_states
    puts "========\n" + self.class.name + "##{__method__}" + "\n========\n"

    states = []
    @pieces.each do |piece|
      states.push piece.get_state
    end

    puts "========\n" + self.class.name + "##{__method__}" + "\n========\n"

    return states

  end

  private

  def register_piece(piece)
    if !@piece_lookup[piece.id]
      # if piece.id == nil
      #   piece.set_id(SecureRandom.uuid)
      # end
      @piece_lookup[piece.id] = piece
      @pieces.add(piece)
    end
  end

end

