# 隣接リストを使ったダイクストラ法で、計算量は O(n^2)
# nが大きい場合はヒープを使ったダイクストラ法の使用を推奨
class Dijkstra1
  attr_reader :d

  def initialize(n)
    # @cost[u][v]は辺e=(u,v)のコスト（存在しない場合はINF）
    @cost = {}

    # 頂点sからの最短距離
    @d = Hash.new(Float::INFINITY)

    # すでに使われたかのフラグ
    @used = Hash.new(false)

    # 頂点数
    @v = n
  end

  def add_side(side, cost)
    a, b = side
    @cost[a] ||= Hash.new(Float::INFINITY)
    @cost[a][b] = cost

    @cost[b] ||= Hash.new(Float::INFINITY)
    @cost[b][a] = cost
  end

  def calc_cost(start_node)
    s = start_node
    @d[s] = 0

    while true
      v = -1
      (1..@v).each do |u|
        v = u if !@used[u] && (v == -1 || @d[u] < @d[v])
      end

      break if v == -1

      @used[v] = true

      (1..@v).each do |u|
        @d[u] = [@d[u], @d[v] + @cost[v][u]].min
      end
    end
  end
end

require 'minitest/autorun'
class TestDijkstra1 < MiniTest::Test
  def setup
    d = Dijkstra1.new(5)
    
    d.add_side([1,2], 4)
    d.add_side([1,4], 1)
    d.add_side([2,4], 1)
    d.add_side([2,3], 3)
    d.add_side([3,4], 1)
    d.add_side([3,5], 2)
    d.add_side([4,5], 5)
    @d = d
  end

  def test_calc_cost_for_node1
    @d.calc_cost(1)
    assert_equal({1=>0,2=>2,3=>2,4=>1,5=>4}, @d.d)
  end

  def test_calc_cost_for_node2
    @d.calc_cost(2)
    assert_equal({2=>0,1=>2,3=>2,4=>1,5=>4}, @d.d)
  end

  def test_calc_cost_for_node3
    @d.calc_cost(3)
    assert_equal({3=>0,1=>2,2=>2,4=>1,5=>2}, @d.d)
  end

  def test_calc_cost_for_node4
    @d.calc_cost(4)
    assert_equal({4=>0,1=>1,2=>1,3=>1,5=>3}, @d.d)
  end

  def test_calc_cost_for_node5
    @d.calc_cost(5)
    assert_equal({5=>0,1=>4,2=>4,3=>2,4=>3}, @d.d)
  end
end
