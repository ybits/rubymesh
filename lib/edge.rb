require 'lib/point'

class Edge < Array

  def initialize p1, p2
    @p1 = p1
    @p2 = p2
    self.push(p1, p2)
  end

  def p1
    self[0]
  end
  
  def p2
    self[1]
  end

  def p1= value
    @p1 = value
    self[0] = @p1
  end
  
  def p2= value
    @p2 = value
    self[1] = @p2
  end

  def midpoint
    (@p1 + @p2) / 2
  end

  def == other
    intersection = self.reject do |element|
      !other.include?(element)
    end 
    intersection.size == 2
  end

end
