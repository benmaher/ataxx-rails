class GamePieceModel

  attr_reader :id
  attr_accessor :player_id
  attr_reader :location_id
  attr_reader :location_grid_point
  attr_reader :available_moves
  attr_reader :display_name

  def initialize(player_id=nil, display_name=nil)
    @id = SecureRandom.uuid
    @player_id = player_id
    @location_id = nil
    @location_grid_point = nil
    @available_moves = []
    @display_name = display_name == nil ? "#{player_id}" : "#{display_name}"
  end

  def set_id(id)
    @id = id
  end

  def get_state
    {
      id: @id,
      player_id: @player_id,
      location: {
        id: @location_id,
        x: @location_grid_point.x,
        y: @location_grid_point.y
        },
      moves: Array.new(@available_moves),
      display_name: @display_name
    }
  end

  def load_state(state)
    @id = state[:id]
    @player_id = state[:player_id]
    @location_id = state[:location][:id]
    @location_grid_point = GridPointModel.new(state[:location][:x], state[:location][:y])
    @available_moves = Array.new(state[:moves])
    @display_name = state[:display_name]
    return self
  end


  def set_location(location)
    @location_id = location
  end

  def remove_location
    @location_id = nil
    @location_grid_point = nil
    @available_moves = []
  end

  def allowed_move?(move_location)
    return @available_moves.include?(move_location)
  end

  def update_available_moves(game_grid_model)
    @available_moves.clear

    @location_grid_point = game_grid_model.get_location_grid_point(@location_id)

    x_start = @location_grid_point.x - 2
    x_end = @location_grid_point.x + 2
    y_start = @location_grid_point.y - 2
    y_end = @location_grid_point.y + 2

    x_start.upto(x_end) do |x_coor|
      y_start.upto(y_end) do |y_coor|
        target_location_id = game_grid_model.resolve_location(GridPointModel.new(x_coor, y_coor))
        if game_grid_model.valid_location?(target_location_id) &&
          !game_grid_model.occupied_location?(target_location_id)

          @available_moves.push(target_location_id)
        end
      end
    end
  end

  def has_moves?
    return !@available_moves.empty?
  end

end
