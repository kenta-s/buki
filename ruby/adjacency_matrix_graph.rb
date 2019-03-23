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

# TODO: write test code
