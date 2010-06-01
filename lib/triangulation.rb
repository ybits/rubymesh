require 'lib/triangle'

=begin
subroutine triangulate
input : vertex list
output : triangle list
   initialize the triangle list
   determine the supertriangle
   add supertriangle vertices to the end of the vertex list
   add the supertriangle to the triangle list
   for each sample point in the vertex list
      initialize the edge buffer
      for each triangle currently in the triangle list
         calculate the triangle circumcircle center and radius
         if the point lies in the triangle circumcircle then
            add the three triangle edges to the edge buffer
            remove the triangle from the triangle list
         endif
      endfor
      delete all doubly specified edges from the edge buffer
         this leaves the edges of the enclosing polygon only
      add to the triangle list all triangles formed between the point 
         and the edges of the enclosing polygon
   endfor
   remove any triangles from the triangle list that use the supertriangle vertices
   remove the supertriangle vertices from the vertex list
end
=end

class Triangle
  attr_accessor :finished
end

class Triangulation 

  def self.triangulate vertices
    vertices.sort!
    super_triangle = self.super_triangle vertices
    
    triangles = []
    triangles.push(super_triangle)
   
    vertices.each do |vertex|
      edges = []
      triangles.each do |triangle|
        next if triangle.finished
        if triangle.circumcircle.circumscribes?(vertex)
          edges += triangle.edges
          triangle.finished = true
        end
      end
      edges = self.remove_duplicate_edges edges
      edges.each do |edge|
        # How can vertex BE in the in edge???
        triangles.push(Triangle.new(edge.p1, edge.p2, vertex))
      end
      puts "Finished: #{triangles}"
    end
    
    triangles = self.remove_triangles_incident_to_super_triangle(
      triangles,
      super_triangle
    )

  end

  def self.remove_triangles triangles, triangles_to_remove
    triangles.reject do |triangle|
      triangles_to_remove.include?(triangle)
    end
  end

  #FIXME THIS SUCKS.
  def self.remove_duplicate_edges edges
    hash = {}
    edges = edges.each do |edge|
      edge.sort!
      key = "#{edge[0]},#{edge[1]}"
      if hash[key].nil?
        hash[key] = 1
      else
        hash[key] = 2
      end
    end
    
    edges = edges.reject do |edge| 
      edge.sort!
      key = "#{edge[0]},#{edge[1]}"
      hash[key] > 1
    end
  end

  def self.remove_triangles_incident_to_super_triangle triangles, super_triangle
    triangles.reject do |triangle|
      triangle.include?(super_triangle.p1) or
      triangle.include?(super_triangle.p2) or
      triangle.include?(super_triangle.p3)
    end
  end 

  def self.remove_vertices_of_super_triangle vertices
    vertices.pop
    vertices.pop
    vertices.pop
    vertices
  end

  def self.super_triangle vertices
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

end
