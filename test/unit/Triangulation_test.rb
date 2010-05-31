require 'test/unit'
require 'lib/triangulation'

class TriangleTest < Test::Unit::TestCase

  def test_initialize
    points = [Point.new(1,1), Point.new(2,2)]
    triangulation = Triangulation.new(points)
    points.each do |vertex|
      assert triangulation.vertices.include?(vertex)
    end
  end

  def test_supertriangle
    flunk
  end
 
  def test_add_supertriangle_vertices
    flunk
  end
  
  def test_add_supertriangle_to_list
    flunk
  end

  def test_something
    flunk
  end
end 
