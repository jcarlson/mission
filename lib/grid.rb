class Grid
  attr_reader :width, :height

  def initialize(width, height)

    @width = Integer(width)
    @height = Integer(height)

    raise ArgumentError if self.width < 1 || self.height < 1
  end

  def contains_x(x)
    0 <= x && x <= width
  end

  def contains_y(y)
    0 <= y && y <= height
  end
end
