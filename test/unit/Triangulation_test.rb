require 'test/unit'
require 'lib/triangulation'

class TriangleTest < Test::Unit::TestCase

  def test_initialize
    points = [
      Point.new(2.0,4.0), 
      Point.new(1.0,1.0), 
      Point.new(2.0,2.0), 
      Point.new(3.0,3.0),
      Point.new(5.0, 3.5)
    ]
    Triangulation.triangulate(points)
  end
  
  def test_a_bunch
    points = []
    (1..100).each do |index|
      points.push(Point.new(rand(5000).to_f, rand(5000).to_f))
    end
    triangles = Triangulation.triangulate(points)
    puts "Got #{triangles.size} triangles"
  end

  def test_spanning_tree
    points = []
    (1..100).each do |index|
      points.push(Point.new(rand(5000).to_f, rand(5000).to_f))
    end
    triangles = Triangulation.triangulate(points)
    edges = Triangulation.spanning_tree triangles
    puts edges.inspect
  end

  def test_remove_triangles_incident_to_super_triangle
    t1 = Triangle.new(
      Point.new(1,1),
      Point.new(2,2),
      Point.new(3.3)
    )
    t2 = Triangle.new(
      Point.new(1,1),
      Point.new(2,4),
      Point.new(3.3)
    )
    t3 = Triangle.new(
      Point.new(1,2),
      Point.new(2,5),
      Point.new(3.4)
    )
    super_triangle = Triangle.new(
      Point.new(1,1),
      Point.new(2,4),
      Point.new(3.5)
    ) 
    triangles = {
      super_triangle.sort.to_s => super_triangle,
      t1.sort.to_s => t1,
      t2.sort.to_s => t2,
      t3.sort.to_s => t3,
    }
    
    triangles = Triangulation.remove_triangles_incident_to_super_triangle(
      triangles, 
      super_triangle
    ).values

    assert !triangles.include?(t1)
    assert !triangles.include?(t2)
    assert !triangles.include?(super_triangle)
    assert triangles.include?(t3)
  end
  
  def test_remove_duplicate_edges
    e1 = Edge.new(Point.new(1,1), Point.new(1,2))
    e2 = Edge.new(Point.new(1,2), Point.new(1,1))
    e3 = Edge.new(Point.new(2,1), Point.new(1,2))
    edges = [e1, e2, e3]

    edges = Triangulation.remove_duplicate_edges edges

    assert !edges.include?(e1)
    assert !edges.include?(e2)
    assert edges.include?(e3)
  end


end 
