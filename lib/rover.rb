class Rover
  attr_reader :grid, :x, :y, :bearing

  ROTATIONS = {
      'N' => 'W',
      'W' => 'S',
      'S' => 'E',
      'E' => 'N'
  }

  def initialize(grid, x, y, bearing)
    @grid = grid
    @x = Integer(x)
    @y = Integer(y)
    @bearing = bearing

    raise ArgumentError unless grid.contains_x(self.x) && grid.contains_y(self.y)
    raise ArgumentError unless ROTATIONS.has_key?(self.bearing)
  end

  def rotate_left
    @bearing = ROTATIONS.fetch(bearing)
  end

  def rotate_right
    @bearing = ROTATIONS.invert.fetch(bearing)
  end

  def move_forward
    case bearing
    when 'N', 'S'
      next_y = bearing == 'N' ? y + 1 : y - 1
      raise RuntimeError unless grid.contains_y(next_y)
      @y = next_y
    when 'E', 'W'
      next_x = bearing == 'E' ? x + 1 : x - 1
      raise RuntimeError unless grid.contains_x(next_x)
      @x = next_x
    end

    def position
      [x, y, bearing].join(' ')
    end
  end
end
