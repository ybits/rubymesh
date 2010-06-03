class TreeNode
    
  attr_accessor :data, :depth, :degree, 
                :parent, :node_id, :children

  def initialize data, depth = 0, degree = 0
    @data = data
    @depth = depth
    @degree = degree
    @children = []
  end

  def parent= node
    @parent = node.node_id
  end

  def add_child node
    @children.push(node.node_id)
    @degree+= 1
  end

  def remove_child node
    result = @children.delete(node.node_id)
    @degree -= 1 unless result.nil?
  end

end
