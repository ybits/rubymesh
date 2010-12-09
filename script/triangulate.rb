require_relative '../lib/triangulation'
require 'ruby-prof'

points = []
(1..3000).each do |index|
  points.push(Point.new(rand(5000).to_f, rand(5000).to_f))
end
t = Delaunay::Triangulation.new(points)
triangles = t.triangulate 
#puts triangles
puts "Got #{triangles.size} triangles"
edges = t.spanning_tree triangles
puts "Got #{edges.size} edges for spanning tree"
