require_relative 'point'

class Edge < Struct.new(:p1, :p2)
  include Comparable  

  def midpoint
    (p1 + p2) / 2
  end

  def == other
    (p1 == other.p1 && p2 == other.p2) || (p1 == other.p2 && p2 == other.p1)
  end

=begin
  def <=> other
    clone = self.sort
    other_clone = other.sort
    clone[0] != other_clone[0] ? clone[0] <=> other_clone[0] : clone[1] <=> other_clone[1]
  end
=end

  def to_s
    "[#{p1},#{p2}]"
  end

end
