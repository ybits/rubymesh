require 'test/unit'
require 'lib/point'

class PointTest < Test::Unit::TestCase
  def setup
    
  end

  def test_base
    point = Point.new(1,1,1)
    assert 1, point.x
    assert 1, point.y
    assert 1, point.z
  end

  def test_default_values
    point = Point.new
    assert 0, point.x
    assert 0, point.y
    assert 0, point.z
  end

  def test_accessors
    point = Point.new
    point.x = 1
    point.y = 2
    point.z = 3
    assert 1, point.x
    assert 2, point.y
    assert 3, point.z
  end
  
  def test_addition
    p1 = Point.new(1,1,1)
    p2 = p1 + p1
    assert 2, p2.x
    assert 2, p2.y
    assert 2, p2.z
    
    assert_raise Point::InvalidArgument do
      p3 = p1 + "invalid"
    end
  end

  def test_subtraction
    p1 = Point.new(1,1,1)
    p2 = p1 - p1
    assert 0, p2.x
    assert 0, p2.y
    assert 0, p2.z
    
    assert_raise Point::InvalidArgument do
      p3 = p1 - "invalid"
    end
  end
  
  def test_comparable
    p1 = Point.new(1,1,1)
    p2 = Point.new(0,1,1)
    p3 = Point.new(1,0,1)
    p4 = Point.new(0,0,1)

    assert p1 > p2
    assert p1 > p3
    assert p1 > p4

    assert p4 < p2
    assert p4 < p3

    assert p3 == p3
  end

  def test_sortable
    p1 = Point.new(1,1,1)
    p2 = Point.new(0,1,1)
    p3 = Point.new(1,0,1)
    p4 = Point.new(0,0,1)
    points = [p1, p2, p3, p4]
    points.sort!
    
    assert_equal p4, points[0]
    assert_equal p2, points[1]
    assert_equal p3, points[2]
    assert_equal p1, points[3]
  end

  def test_scalar_multiplication
    p1 = Point.new(3,6,9)
    p2 = p1 * 2
    
    assert_equal 6, p2.x
    assert_equal 12, p2.y
    assert_equal 18, p2.z

    assert_raise Point::InvalidArgument do
      p3 = p1 * "invalid"
    end
  end

  def test_scalar_division
    p1 = Point.new(3,6,9)
    p2 = p1 / 3
    
    assert_equal 1, p2.x
    assert_equal 2, p2.y
    assert_equal 3, p2.z
    
    assert_raise Point::InvalidArgument do
      p3 = p1 / "invalid"
    end
  end

  def test_to_string
    p1 = Point.new(1,2,3)
    assert_equal "(1,2,3)", p1.to_s
  end

end
