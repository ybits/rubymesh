require_relative 'triangle'

class Triangle
  attr_accessor :finished
end

module Delaunay
  class Triangulation 

    attr_accessor :vertices, :triangles

    def initialize vertices
      self.vertices = vertices
      self.vertices.uniq!
      self.vertices.sort!
      self.triangles = []
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

      super_triangle_vertices = [super_triangle.p1, 
        super_triangle.p2, 
        super_triangle.p3
      ]

      self.triangles.delete_if do |triangle| 
        (super_triangle_vertices.include?(triangle.p1) || 
        super_triangle_vertices.include?(triangle.p2) || 
        super_triangle_vertices.include?(triangle.p3)) 
      end

      self.triangles
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

      triangle = Triangle.new(
        Point.new(x_mid - max_change*2, y_mid - max_change),
        Point.new(x_mid, y_mid + max_change*2),
        Point.new(x_mid + max_change*2, y_mid - max_change)
      )
    end

    def spanning_tree triangles
      edge_list = self.build_spanning_tree_edge_list triangles
    end

    def spanning_tree_edge_list triangles
      edge_list = triangles.inject({}) do |h,triangle| 
        edges = triangle.edges
        edges.each do |edge|
          key = edge.sort.to_s
          if h.key?(key)
            h[key].push(triangle)
          else
            h[key] = [triangle]
          end
        end 
        h
      end 
      edge_list
    end

  end
end
