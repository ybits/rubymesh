require 'test/unit'
require_relative '../test_helper'
require 'lib/triangulation'

class TriangulationTest < Test::Unit::TestCase

  def test_initialize
    points = [
      Point.new(2.0,4.0), 
      Point.new(1.0,1.0), 
      Point.new(2.0,2.0), 
      Point.new(3.0,3.0),
      Point.new(5.0, 3.5)
    ]
    t = Delaunay::Triangulation.new(points)
    t.triangulate
  end
  
  def test_a_bunch
    points = []
    (1..1000).each do |index|
      points.push(Point.new(rand(5000).to_f, rand(5000).to_f))
    end
    t = Delaunay::Triangulation.new(points)
    triangles = t.triangulate
    puts "Got #{triangles.size} triangles"
  end

  def test_spanning_tree
    points = []
    (1..100).each do |index|
      points.push(Point.new(rand(5000).to_f, rand(5000).to_f))
    end
    t = Delaunay::Triangulation.new(points)
    triangles = t.triangulate
    #edges = Triangulation.spanning_tree triangles
    #puts edges.inspect
  end


end 
