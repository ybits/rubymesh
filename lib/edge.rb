require 'lib/point'

class Edge < Array
  include Comparable  

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

=begin
  def == other
    intersection = self.reject do |element|
      !other.include?(element)
    end 
    intersection.size == 2
  end
=end

  def <=> other
    clone = self.sort
    other_clone = other.sort
    clone[0] != other_clone[0] ? clone[0] <=> other_clone[0] : clone[1] <=> other_clone[1]
  end

  def to_s
    "[#{p1},#{p2}]"
  end

end
