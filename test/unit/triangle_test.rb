require 'test/unit'
require_relative '../test_helper'
require 'lib/triangle'

class TriangleTest < Test::Unit::TestCase
  
  def setup
  end

  def test_base
    p1 = Point.new(0, 0, 0)
    p2 = Point.new(1, 1, 1)
    p3 = Point.new(2, 2, 2)
    triangle = Triangle.new(p1, p2, p3)
    assert_equal p1, triangle.p1
    assert_equal p2, triangle.p2
    assert_equal p3, triangle.p3
    assert_equal p1, triangle[0]
    assert_equal p2, triangle[1]
    assert_equal p3, triangle[2]
  end

  def test_accessors
    p1 = Point.new(0, 0, 0)
    p2 = Point.new(1, 1, 1)
    p3 = Point.new(2, 2, 2)
    triangle = Triangle.new(p3, p1, p2)
    triangle.p1 = p1
    triangle[1] = p2
    triangle[2] = p3
    assert_equal p1, triangle[0]
    assert_equal p2, triangle.p2
    assert_equal p3, triangle.p3
  end

  def test_centroid
    triangle = Triangle.new(
      Point.new(1,1,1),
      Point.new(1,1,1),
      Point.new(4,4,4)  
    )
    assert_equal Point.new(2,2,2), triangle.centroid
  end

  def test_adjacent
    t1 = Triangle.new(
      Point.new(1,1,1),
      Point.new(1,1,2),
      Point.new(4,4,4)  
    )
    t2= Triangle.new(
      Point.new(1,1,1),
      Point.new(1,1,2),
      Point.new(5,5,5)  
    )
    t3= Triangle.new(
      Point.new(1,1,3),
      Point.new(1,1,2),
      Point.new(5,5,6)  
    )
   
    assert t1.adjacent?(t2)
    assert !t2.adjacent?(t3)
  end

  def test_equals
    t1 = Triangle.new(
      Point.new(1,1,1),
      Point.new(1,1,2),
      Point.new(4,4,4)  
    )
    t2= Triangle.new(
      Point.new(1,1,1),
      Point.new(1,1,2),
      Point.new(4,4,4)  
    )
    t3= Triangle.new(
      Point.new(1,1,3),
      Point.new(1,1,2),
      Point.new(5,5,6)  
    )
   
    assert t1 == t2
    assert t2 != t3 
  end

  def test_circumcenter
    t1 = Triangle.new(
      Point.new(-1,-1,0),
      Point.new(1,-1,0),
      Point.new(1,1,0)  
    )
    radius1 = Math.sqrt(2)
    
    t2 = Triangle.new(
      Point.new(0,0,0),
      Point.new(2,0,0),
      Point.new(2,1,0)  
    )
    radius2 = Math.sqrt(2)
    
    t3 = Triangle.new(
      Point.new(1.0,3.0),
      Point.new(7.0,-3.0),
      Point.new(9.0,5.0)  
    )
  
#    assert_equal Circle.new(Point.new(0,0.5), radius1), t1.circumcircle
#    assert_equal Circle.new(Point.new(1,0.5), radius2), t2.circumcircle
#    assert_equal Point.new(17.0/3.0,5.0/3.0), t3.circumcircle.center
  end

  def test_edges
    t1 = Triangle.new(
      Point.new(-1,-1,0),
      Point.new(1,-1,0),
      Point.new(1,1,0)  
    )
    edges = t1.edges
    assert edges.include?(Edge.new(Point.new(-1,-1), Point.new(1,-1)))
    assert edges.include?(Edge.new(Point.new(1,-1), Point.new(-1,-1)))
    assert edges.include?(Edge.new(Point.new(1,1), Point.new(1,-1)))
    assert !edges.include?(Edge.new(Point.new(0,-1), Point.new(1,-1)))
  end

  def test_to_s
    t1 = Triangle.new(
      Point.new(-1,-1,0),
      Point.new(1,-1,0),
      Point.new(1,1,0)  
    )

    assert_equal "[(-1.0,-1.0,0.0),(1.0,-1.0,0.0),(1.0,1.0,0.0)]", t1.to_s
  end

end
