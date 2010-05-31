require 'lib/point'
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

  def centroid
    return (@p1 + @p2 + @p3) / 3
  end

  def adjacent? other
    intersection = self.reject do |element|
      !other.include?(element)
    end
    intersection.length == 2
  end

  def == other
    intersection = self.reject do |element|
      !other.include?(element)
    end
    intersection.length == 3
  end

  def circumcircle
    if !@circumcircle.nil?
      return @circumcircle
    end
  
    center = circumcenter
    radius = circumcircle_radius(center)

    @circumcircle = Circle.new(center, radius)
  end

  private

    def reset_circumcircle
      @circumcircle = nil
    end

    def circumcircle_radius center
      Math.sqrt((@p1.x - center.x)**2 + (@p1.y - center.y)**2) 
    end

    def circumcenter
      Point.new(circumcenter_x, circumcenter_y) 
    end

    def circumcenter_denominator
      denominator = 2 * 
        (
          @p1.x * (@p2.y - @p3.y) +
          @p2.x * (@p3.y - @p1.y) + 
          @p3.x * (@p1.y - @p2.y)
        )
    end

    def circumcenter_x
      circumcenter_x = 
        (
          (@p1.y**2 + @p1.x**2) * (@p2.y - @p3.y) +
          (@p2.y**2 + @p2.x**2) * (@p3.y - @p1.y) +
          (@p3.y**2 + @p3.x**2) * (@p1.y - @p2.y)
        ) / circumcenter_denominator 
    end

    def circumcenter_y
      circumcenter_y = 
        (
          (@p1.y**2 + @p1.x**2) * (@p3.x - @p2.x) +
          (@p2.y**2 + @p2.x**2) * (@p1.x - @p3.x) +
          (@p3.y**2 + @p3.x**2) * (@p2.x - @p1.x)
        ) / circumcenter_denominator 
    end

end
