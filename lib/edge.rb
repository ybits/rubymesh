require_relative 'point'

class Edge < Struct.new(:p1, :p2)
  def midpoint
    (p1 + p2) / 2
  end

  def == other
    (p1 == other.p1 && p2 == other.p2) || (p1 == other.p2 && p2 == other.p1)
  end

  def hash
    self.sort.to_s
  end
  
  def to_s
    "[#{p1},#{p2}]"
  end

end
