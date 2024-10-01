# frozen_string_literal: true

# Tree Node representaion
class Node
  include Comparable
  attr_accessor :data, :left, :right

  def initialize(data, left = nil, right = nil)
    @data = data
    @left = left
    @right = right
  end

  def <=>(other)
    data <=> other.data
  end
end

# binary search tree implementation
class Tree
  def initialize(array)
    @root = build_tree(array)
  end

  def build_tree(array)
    filtered = array.uniq.sort
    length = filtered.length

    build_tree_rec(0, length - 1, filtered)
  end

  def build_tree_rec(left, right, array)
    return if left > right

    mid = left + ((right - left) / 2)
    root = Node.new(array[mid])
    root.left = build_tree_rec(left, mid - 1, array)
    root.right = build_tree_rec(mid + 1, right, array)
    root
  end

  def insert(value)
    current = @root

    until current.nil?
      if current.data > value
        if current.left.nil?
          current.left = Node.new(value)
          return
        end
        current = current.left
      elsif current.data < value
        if current.right.nil?
          current.right = Node.new(value)
          return
        end
        current = current.right
      else
        return
      end
    end
  end

  def delete(value, current = @root, prev = nil)
    return if current.nil?

    if current.data == value
      return if current.left.nil? && current.right.nil?

      temp = current
      if temp.left.nil?
        temp = temp.right
        return temp if temp.left.nil?

        temp = temp.left until temp.left.nil?
      else
        temp = temp.left
        return temp if temp.right.nil?

        temp = temp.right until temp.right.nil?
      end
      delete(temp.data, @root, nil)
      current.data = temp.data

    elsif current.data > value
      current.left = delete(value, current.left, current)
    else
      current.right = delete(value, current.right, current)
    end
    current
  end

  def find(value)
    current = @root
    until current.nil?
      return current if current.data == value

      current = if current.data > value
                  current.left
                else
                  current.right
                end
    end
  end

  def level_order
    array = []
    que = [@root]
    until que.empty?
      node = que.pop
      array << node.data
      yield node.data if block_given?
      que.unshift(node.left) unless node.left.nil?
      que.unshift(node.right) unless node.right.nil?
    end
    array
  end

  def preorder(&block)
    array = _preorder
    if block_given?
      array.each(&block)
    else
      array
    end
  end

  def inorder(&block)
    array = _inorder
    if block_given?
      array.each(&block)
    else
      array
    end
  end

  def postorder(&block)
    array = _postorder
    if block_given?
      array.each(&block)
    else
      array
    end
  end

  def height(node = @root)
    que = []
    node = if node.is_a? Numeric
             find(node)
           else
             node
           end

    que << node unless node.nil?
    count = 0

    until que.empty?
      que_length = que.length
      que_length.times do
        current = que.pop
        que.unshift(current.left) unless current.left.nil?
        que.unshift(current.right) unless current.right.nil?
      end
      count += 1
    end
    count - 1
  end

  def depth(node)
    que = []
    node = if node.is_a? Numeric
             find(node)
           else
             node
           end

    que << @root unless @root.nil?
    count = 0

    until que.empty?
      que_length = que.length
      que_length.times do
        current = que.pop
        return count if node == current

        que.unshift(current.left) unless current.left.nil?
        que.unshift(current.right) unless current.right.nil?
      end
      count += 1
    end
    count
  end

  def balanced?(current = @root)
    return true if current.nil?

    (height(current.left) - height(current.right)).abs <= 1 && balanced?(current.left) && balanced?(current.right)
  end

  def rebalance
    array = level_order
    @root = build_tree(array)
  end

  def pretty_print(node = @root, prefix = '', is_left = true)
    pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
    pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
  end

  private

  def _preorder(current = @root)
    return [] if current.nil?

    [current.data] + _preorder(current.left) + _preorder(current.right)
  end

  def _inorder(current = @root)
    return [] if current.nil?

    _inorder(current.left) + [current.data] + _inorder(current.right)
  end

  def _postorder(current = @root)
    return [] if current.nil?

    _postorder(current.left) + _postorder(current.right) + [current.data]
  end
end
