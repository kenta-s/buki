class UnionFind
  attr :parent

  def initialize(nodes)
    @parent = {}
    nodes.each do |node|
      parent[node] = -1
    end
  end

  def root(x)
    if parent[x] < 0
      x
    else
      parent[x] = root(parent[x])
    end
  end

  def size(x)
    return -parent[root(x)]
  end

  def unite(x, y)
    rx = root(x)
    ry = root(y)
    if rx == ry
      return false
    else
      if size(rx) < size(ry)
        rx, ry = ry, rx
      end

      parent[rx] += parent[ry]
      parent[ry] = rx

      return true
    end
  end
end

require 'minitest/autorun'

class TestUnionFind < Minitest::Test
  def test_root
    uf = UnionFind.new([1,2,3,4])
    assert_equal 1, uf.root(1)
    assert_equal 2, uf.root(2)
    assert_equal 3, uf.root(3)
    assert_equal 4, uf.root(4)
  end

  def test_size
    uf = UnionFind.new([1,2,3,4])
    assert_equal 1, uf.size(1)
    assert_equal 1, uf.size(2)
    assert_equal 1, uf.size(3)
    assert_equal 1, uf.size(4)
  end

  def test_unite
    uf = UnionFind.new([1,2,3,4])
    uf.unite(1,2)
    assert_equal 1, uf.root(1)
    assert_equal 1, uf.root(2)
    assert_equal 3, uf.root(3)
    assert_equal 2, uf.size(2)
    assert_equal 1, uf.size(3)
    assert_equal 1, uf.size(4)

    uf.unite(3,4)
    assert_equal 3, uf.root(4)
    assert_equal 2, uf.size(3)

    uf.unite(1,4)
    assert_equal 1, uf.root(4)
    assert_equal 4, uf.size(3)
  end
end
