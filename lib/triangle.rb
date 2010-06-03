require 'lib/point'
require 'lib/edge'
require 'lib/circle'

class Triangle < Array

  def initialize p1, p2, p3
    @p1 = p1
    @p2 = p2
    @p3 = p3
    self.push(@p1, @p2, @p3)
  end

  def p1
    self[0]
  end

  def p2
    self[1]
  end

  def p3
    self[2]
  end

  def p1= value
    @p1 = value
    self[0] = @p1
    reset_circumcircle
  end

  def p2= value
    @p2 = value
    self[1] = @p2
    reset_circumcircle
  end

  def p3= value
    @p3 = value
    self[2] = @p3
    reset_circumcircle
  end

  def to_s
    "[#{p1},#{p2},#{p3}]"
  end

  def centroid
    return (p1 + p2 + p3) / 3.0
  end

  def edges
    return [
      Edge.new(self[0], self[1]), 
      Edge.new(self[1], self[2]), 
      Edge.new(self[2], self[0])
    ]    
  end

  def adjacent? other
    intersection = self.reject do |element|
      !other.include?(element)
    end
    intersection.length == 2
  end

=begin
  def == other
    intersection = self.reject do |element|
      !other.include?(element)
    end
    intersection.length == 3
  end
=end

  def <=> other
    clone = self.sort
    other_clone = other.sort
    if clone[0] != other_clone[0]
      return clone[0] <=> other_clone[0]
    elsif clone[1] != other_clone[1]
      return clone[1] <=> other_clone[1]
    else
      return clone[2] <=> other_clone[2]
    end
  end

  def circumcircle
    #if !@circumcircle.nil?
    #  return @circumcircle
    #end
  
    center = circumcenter
    radius = circumcircle_radius(center)
    Circle.new(center, radius)
  end

  private

    def reset_circumcircle
      @circumcircle = nil
    end

    def circumcircle_radius center
      #puts "Self: #{self}"
      #puts "Center: #{center}"
      Math.sqrt((p1.x - center.x)**2.0 + (p1.y - center.y)**2.0) 
    end

    def circumcenter
      Point.new(circumcenter_x, circumcenter_y) 
    end

    def circumcenter_denominator
      denominator = 2.0 * 
        (
          (p1.x * (p2.y - p3.y)) +
          (p2.x * (p3.y - p1.y)) + 
          (p3.x * (p1.y - p2.y))
        )
    end

    def circumcenter_x
      exp = 2.0
      circumcenter_x = 
        (
          (p1.y**exp + p1.x**exp) * (p2.y - p3.y) +
          (p2.y**exp + p2.x**exp) * (p3.y - p1.y) +
          (p3.y**exp + p3.x**exp) * (p1.y - p2.y)
        ) / circumcenter_denominator 
    end

    def circumcenter_y
      exp = 2.0
      circumcenter_y = 
        (
          (p1.y**exp + p1.x**exp) * (p3.x - p2.x) +
          (p2.y**exp + p2.x**exp) * (p1.x - p3.x) +
          (p3.y**exp + p3.x**exp) * (p2.x - p1.x)
        ) / circumcenter_denominator 
    end

end
