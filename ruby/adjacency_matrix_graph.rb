# Adjacency matrix graph
class AMGraph
  attr :graph, :visited

  # n: 頂点の数
  def initialize(n)
    @n = n
    reset
  end

  # parameter is an array like: [1, 2]
  def set_side(side)
    a, b = side
    @graph[a][b] = 1
    @graph[b][a] = 1
  end

  def visit(node)
    @visited[node] = true
  end

  def unvisit(node)
    @visited[node] = false
  end

  def recursively_visit(node)
    return if visited?(node)
    visit(node)
    visitable_nodes(node).each do |node|
      recursively_visit(node)
    end
  end

  def visited?(node)
    @visited[node]
  end

  def visitable_nodes(node)
    nodes = []
    @graph[node].each do |node|
      next if node[0] == node
      next if node[1] != 1
      next if visited?(node[0])
      nodes << node[0]
    end
    nodes
  end

  def all_visited?
    @nodes.each do |node|
      return false unless @visited[node]
    end
    true
  end

  def reset_visited
    @visited = Hash.new(false)
  end

  def reset
    @visited = Hash.new(false)
    @graph = {}
    @nodes = []
    @n.times.with_index(1) do |_,i|
      @nodes << i
      @visited[i] = false
      @graph[i] = {}
      @n.times.with_index(1) do |_,j|
        @graph[i][j] = 0
      end
    end
  end
end

require 'minitest/autorun'
class TestAMGraph < MiniTest::Test
  def test_graph
    graph1 = AMGraph.new(3)
    assert_equal({1=>{1=>0,2=>0,3=>0},2=>{1=>0,2=>0,3=>0},3=>{1=>0,2=>0,3=>0}}, graph1.graph)

    graph2 = AMGraph.new(2)
    assert_equal({1=>{1=>0,2=>0},2=>{1=>0,2=>0}}, graph2.graph)
  end

  def test_set_side
    graph = AMGraph.new(3)
    graph.set_side([1,2])
    assert_equal({1=>{1=>0,2=>1,3=>0},2=>{1=>1,2=>0,3=>0},3=>{1=>0,2=>0,3=>0}}, graph.graph)

    graph.set_side([1,3])
    assert_equal({1=>{1=>0,2=>1,3=>1},2=>{1=>1,2=>0,3=>0},3=>{1=>1,2=>0,3=>0}}, graph.graph)
  end

  def test_visit_and_unvisit
    graph = AMGraph.new(2)
    assert_equal({1=>false,2=>false}, graph.visited)

    graph.visit(2)
    assert_equal({1=>false,2=>true}, graph.visited)

    graph.visit(1)
    assert_equal({1=>true,2=>true}, graph.visited)

    graph.unvisit(1)
    assert_equal({1=>false,2=>true}, graph.visited)

    graph.unvisit(2)
    assert_equal({1=>false,2=>false}, graph.visited)
  end

  def test_visited?
    graph = AMGraph.new(2)
    refute graph.visited?(1)
    refute graph.visited?(2)

    graph.visit(1)
    assert graph.visited?(1)
    refute graph.visited?(2)

    graph.visit(2)
    assert graph.visited?(1)
    assert graph.visited?(2)
  end

  def test_all_visited?
    graph = AMGraph.new(2)
    graph.visit(1)
    refute graph.all_visited?

    graph.visit(2)
    assert graph.all_visited?
  end

  def test_recursively_visit
    graph1 = AMGraph.new(3)
    graph1.set_side([1,2])
    graph1.set_side([2,3])

    graph1.recursively_visit(1)
    assert graph1.all_visited?

    graph2 = AMGraph.new(5)
    graph2.set_side([1,2])
    graph2.set_side([2,3])
    graph2.set_side([4,5])

    graph2.recursively_visit(2)
    refute graph2.all_visited?

    graph2.recursively_visit(5)
    assert graph2.all_visited?
  end

  def test_visitable_nodes
    graph = AMGraph.new(3)
    assert [], graph.visitable_nodes(1)

    graph.set_side([1,2])
    assert [2], graph.visitable_nodes(1)
    assert [1], graph.visitable_nodes(2)

    graph.set_side([2,3])
    assert [2], graph.visitable_nodes(1)
    assert [2], graph.visitable_nodes(3)
    assert [1,3], graph.visitable_nodes(2)

    graph.visit(2)
    assert [], graph.visitable_nodes(1)
    assert [], graph.visitable_nodes(3)
    assert [1,3], graph.visitable_nodes(2)
  end

  def test_reset_visited
    graph = AMGraph.new(3)
    [1,2,3].each {|i| graph.visit(i)}

    assert graph.all_visited?

    graph.reset_visited
    refute graph.visited?(1)
    refute graph.visited?(2)
    refute graph.visited?(3)
  end
end
