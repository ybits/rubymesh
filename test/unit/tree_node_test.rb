require 'test/unit'
require 'lib/tree_node'

class TreeNodeTest< Test::Unit::TestCase

  def test_base
    node = TreeNode.new('ryan', 1, 2)
    assert_equal 'ryan', node.data
    assert_equal 1, node.depth
    assert_equal 2, node.degree
    assert_nil node.node_id
  end

  def test_parent
    parent = TreeNode.new('parent', 1, 2)
    parent.node_id = 0
    node = TreeNode.new('child', 2, 3)
    node.parent = parent
    assert_equal parent.node_id, node.parent 
  end

  def test_child
    child = TreeNode.new('child')
    child.node_id = 1
    node = TreeNode.new('parent')
    node.add_child child  
    children = node.children

    assert_equal 1, node.degree
    assert children.include?(child.node_id)
    assert_equal 1, children.size
    
    node.remove_child child

    assert_equal 0, node.degree
    assert_equal 0,  children.size
  end
  
end
