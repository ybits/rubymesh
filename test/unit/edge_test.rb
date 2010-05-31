require 'test/unit'
require 'lib/edge'

class EdgeTest < Test::Unit::TestCase
  
  def test_base
    p1 = Point.new(1,1)
    p2 = Point.new(2,2)
    edge = Edge.new(p1, p2)
    
    assert_equal p1, edge.p1
    assert_equal p2, edge.p2 
  end

  def test_accessors
    p1 = Point.new(1,1)
    p2 = Point.new(2,2)
    edge = Edge.new(p1, p2)
    edge[0] = p2
    edge.p2 = p1
    
    assert_equal p2, edge.p1
    assert_equal p1, edge[1]
  end

  def test_midpoint
    p1 = Point.new(6,6)
    p2 = Point.new(2,2)
    edge = Edge.new(p1, p2)
    assert_equal Point.new(4,4), edge.midpoint  
  end

  def test_equals
    p1 = Point.new(1,1)
    p2 = Point.new(2,2)
    edge1 = Edge.new(p1, p2)

    p3 = Point.new(1,1)
    p4 = Point.new(2,2)
    edge2 = Edge.new(p3, p4)

    p5 = Point.new(3,3)
    edge3 = Edge.new(p1, p5)

    assert edge1 == edge2
    assert edge1 != edge3
  end

end
