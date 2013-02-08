class AtaxxBoard < ActiveRecord::Base
    attr_accessible :name, :x_size, :y_size, :blocked_locations, :initial_pieces

end
