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
    vertices.uniq!
    vertices.sort!
    super_triangle = self.super_triangle vertices
    
    triangles = {}
    triangles[super_triangle.sort.to_s] = super_triangle
  
    vertices.each do |vertex|
      edges = []
      triangles_to_delete = []
      triangles.each do |key, triangle|
        unless triangles[key].finished
          circumcircle = triangle.circumcircle
          if circumcircle.center.x + circumcircle.radius < vertex.x
            triangles[key].finished = true
          end
          if circumcircle.circumscribes?(vertex)
            edges += triangle.edges
            triangles_to_delete.push(key)
          end
        end
      end

      triangles_to_delete.each do |key|
        triangles.delete(key)
      end

      edges = self.remove_duplicate_edges(edges)
      edges.each do |edge|
        new_triangle = Triangle.new(edge[0], edge[1], vertex)
        triangles[new_triangle.sort.to_s] = new_triangle
      end
    end
   
    triangles = self.remove_triangles_incident_to_super_triangle(
      triangles,
      super_triangle
    )

    triangles.values
  end

  def self.remove_duplicate_edges edges
    counts = edges.inject(Hash.new(0)) {|h,x| h[x.sort.to_s]+=1;h}  
    edges = edges.reject do |edge| 
      key = edge.sort.to_s
      counts[key] > 1
    end
    edges
  end

  def self.remove_triangles_incident_to_super_triangle triangles, super_triangle
    t_list = triangles.values
    t_list.each do |t|
      if t.include?(super_triangle.p1) or
         t.include?(super_triangle.p2) or
         t.include?(super_triangle.p3)
        triangles.delete(t.sort.to_s)
      end
    end
    triangles
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
