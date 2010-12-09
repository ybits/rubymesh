require_relative 'point'

class Circle
  
  attr_accessor :center, :radius

  def initialize center, radius
    @center = center
    @radius = radius.to_f
  end

  def == other
    @center == other.center and @radius == other.radius
  end

  def circumscribes? point
    squared_dist = (@center.x - point.x) ** 2.0 + (center.y - point.y) ** 2.0
    squared_dist <= @radius ** 2.0
  end

end
