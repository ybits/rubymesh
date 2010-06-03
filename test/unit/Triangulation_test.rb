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
  
  def test_a_thousand
    points = []
    (1..1000).each do |index|
      points.push(Point.new(rand(5000).to_f, rand(5000).to_f))
    end
    Triangulation.triangulate(points)
  end

  def test_remove_triangles
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
      Point.new(3,1),
      Point.new(2,2),
      Point.new(3.5)
    )
    t4 = Triangle.new(
      Point.new(1,7),
      Point.new(2,2),
      Point.new(9.3)
    )
    triangles = [t1, t2, t3, t4]
    triangles_to_remove = [t2, t4]

    triangles = Triangulation.remove_triangles(triangles, triangles_to_remove)

    assert triangles.include?(t1)
    assert triangles.include?(t3)
    assert !triangles.include?(t2)
    assert !triangles.include?(t4)
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
    triangles = [super_triangle, t1, t2, t3]
    
    triangles = Triangulation.remove_triangles_incident_to_super_triangle(
      triangles, 
      super_triangle
    )

    assert !triangles.include?(t1)
    assert !triangles.include?(t2)
    assert !triangles.include?(super_triangle)
    assert triangles.include?(t3)
  end
  
  def test_remove_vertices_of_super_triangle
    vertices = [
      Point.new(5.5, 3.333),
      Point.new(2.3, 12.3),
      Point.new(11, 0)
    ]
    
    super_triangle = Triangulation.super_triangle vertices
    vertices.push(super_triangle.p1, super_triangle.p2, super_triangle.p3)
    vertices = Triangulation.remove_vertices_of_super_triangle vertices
    
    assert vertices.include?(Point.new(5.5, 3.333))
    assert vertices.include?(Point.new(2.3, 12.3))
    assert vertices.include?(Point.new(11, 0))
    assert !vertices.include?(super_triangle.p1)
    assert !vertices.include?(super_triangle.p2)
    assert !vertices.include?(super_triangle.p3)
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

  def test_add_edges_of_triangle
    e1 = Edge.new(Point.new(1,1), Point.new(1,2))
    t1 = Triangle.new(
      Point.new(1,1),
      Point.new(1,2),
      Point.new(2,1)
    )
    t2 = Triangle.new(
      Point.new(1,1),
      Point.new(1,2),
      Point.new(2,1)
    )
    edges = {e1.sort.to_s => e1}
    edges = Triangulation.add_edges_of t1, edges
    edges = Triangulation.add_edges_of t2, edges

    assert !edges.key?(e1.sort.to_s)
  end

end 
