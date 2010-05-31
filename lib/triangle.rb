require 'lib/point'

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
  end

  def p2= value
    @p2 = value
    self[1] = @p2
  end

  def p3= value
    @p3 = value
    self[2] = @p3
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

  def points
    self
  end

end
