require 'lib/point'

class Circle
  
  attr_accessor :center, :radius

  def initialize center, radius
    @center = center
    @radius = radius
  end

  def == other
    @center == other.center and @radius == other.radius
  end

  def circumscribes? point
    squared_dist = (@center.x - point.x) ** 2 + (center.y - point.y) ** 2
    return squared_dist <= @radius ** 2 
  end

end
