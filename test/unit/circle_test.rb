require 'test/unit'
require_relative '../test_helper'

class CircleTest < Test::Unit::TestCase
  
  def setup
  end

  def test_base
    center = Point.new(0,0)
    radius = 7
    circle = Circle.new center, radius

    assert_equal center, circle.center
    assert_equal radius, circle.radius
  end

  def test_equals
    circle1 = Circle.new(Point.new(0,0), 5)
    circle2 = Circle.new(Point.new(0,0), 5)
    circle3 = Circle.new(Point.new(1,2), 5)
    circle4 = Circle.new(Point.new(0,0), 6)
   
    assert circle1 == circle2
    assert circle1 != circle3
    assert circle1 != circle4
  end

  def test_circumscribes
    circle = Circle.new(Point.new(0,0), 5)
    point_inside = Point.new(0,1)
    point_outside = Point.new(10,10)
    
    assert circle.circumscribes?(point_inside)
    assert !circle.circumscribes?(point_outside)
  end
end
