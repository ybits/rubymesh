require_relative '../lib/triangulation'
require 'ruby-prof'

points = []
(1..5000).each do |index|
  points.push(Point.new(rand(5000).to_f, rand(5000).to_f))
end
triangles = Triangulation.triangulate(points)
puts "Got #{triangles.size} triangles"
