require_relative 'triangle'

=begin
class Triangle
  attr_accessor :finished, :visited
end

class Edge
  def hash
    self.sort.to_s
  end
end
=end

#module Delaunay
  class Triangulation 

    attr_accessor :vertices, :triangles

    def initialize vertices
      self.vertices = vertices
      self.vertices.uniq!
      self.vertices.sort!
      self.triangles = []
    end

    def to_json
      triangulation = {}
      triangulation[:points] = []
      triangulation[:triangles] = []
      triangulation[:quadrangles] = []

      triangles.each do |t|
        triangulation[:triangles] << [t[0], t[1], t[2]]
      end
      triangulation
    end

    def triangulate 
      super_triangle = super_triangle vertices
      edges = []
      self.triangles << super_triangle
    
      self.vertices.each do |vertex|
        edges.clear
        self.triangles.delete_if do |triangle|
          delete = false
          unless triangle.finished
            circumcircle = triangle.circumcircle
            if circumcircle.center.x + circumcircle.radius < vertex.x
              triangle.finished = true
            end
            if circumcircle.circumscribes?(vertex)
              edges << Edge.new(triangle.p1, triangle.p2)
              edges << Edge.new(triangle.p2, triangle.p3)
              edges << Edge.new(triangle.p3, triangle.p1)
              delete = true
            end
          end
          delete  
        end

        while !edges.empty?
          edge = edges.shift
          rejected = edges.reject! {|e| e == edge}
          if rejected.nil?
            self.triangles << Triangle.new(edge.p1, edge.p2, vertex)
          end
        end 
      
      end

      self.triangles.delete_if do |triangle| 
        super_triangle.coincident? triangle
      end

      self.triangles
    end

    def spanning_tree triangles
      adjacency_list = triangle_adjacency_list triangles
      spanning_tree_edge_list adjacency_list, triangles
    end

  private

    def super_triangle vertices
      x_min = vertices[0].x
      y_min = vertices[0].y
      x_max = x_min
      y_max = y_min
      
      vertices.each do |vertex|
        x_min = [vertex.x, x_min].min
        x_max = [vertex.x, x_max].max
        y_min = [vertex.y, y_min].min
        y_max = [vertex.y, y_max].max
      end 
      
      x_mid = (x_max + x_min) / 2.0
      y_mid = (y_max + y_min) / 2.0
      
      change_in_x = x_max - x_min
      change_in_y = y_max - y_min
      max_change = [change_in_x, change_in_y].max

      Triangle.new(
        Point.new(x_mid - max_change*2, y_mid - max_change),
        Point.new(x_mid, y_mid + max_change*2),
        Point.new(x_mid + max_change*2, y_mid - max_change)
      )
    end

    def triangle_adjacency_list triangles
      adjacency_list = {}
      triangles.each do |triangle| 
        edges = triangle.edges
        edges.each do |edge|
          key = edge.hash
          adjacency_list[key] = [] unless adjacency_list.key?(key)
          adjacency_list[key] << triangle 
        end 
      end 
      adjacency_list
    end

    def spanning_tree_edge_list adjacency_list, triangles
      triangle_queue = [triangles.first]
      spanning_tree_edges = []
      triangle_queue.each do |triangle|  
        edges = triangle.edges
        edges.each do |edge|
          key = edge.hash
          adjacencies = adjacency_list[key]
          adjacencies.each do |adjacent_triangle|
            unless adjacent_triangle == triangle 
              if adjacent_triangle.visited.nil?
                triangle_queue << adjacent_triangle
                adjacent_triangle.visited = true
                spanning_tree_edges << Edge.new(triangle.centroid, adjacent_triangle.centroid)
              end
            end
          end
        end   
        triangle.visited = true
      end
      spanning_tree_edges
    end

  end
#end
