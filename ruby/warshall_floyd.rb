class WarshallFloyd
  attr_reader :d, :n

  # n: count of nodes
  def initialize(n)
    @n = n
    @d = {}
    (1..n).each do |i|
      d[i] = Hash.new(Float::INFINITY)
      d[i][i] = 0
    end
  end

  def add_side(side, cost)
    a, b = side
    d[a][b] = cost
    d[b][a] = cost
  end

  def calc_shortest_paths
    (1..n).each do |k|
      (1..n).each do |i|
        (1..n).each do |j|
          d[i][j] = [d[i][j], d[i][k] + d[k][j]].min
        end
      end
    end
  end
end


require 'minitest/autorun'
class TestWarshallFloyd < MiniTest::Test

  def test_initial_state
    wf = WarshallFloyd.new(3)

    assert_equal Float::INFINITY, wf.d[1][2]
    assert_equal Float::INFINITY, wf.d[2][1]
    assert_equal Float::INFINITY, wf.d[2][3]

    assert_equal 0, wf.d[1][1]
    assert_equal 0, wf.d[2][2]
    assert_equal 0, wf.d[3][3]
  end

  def test_add_side
    wf = WarshallFloyd.new(3)

    wf.add_side([1,2], 3)

    assert_equal 3, wf.d[1][2]
    assert_equal 3, wf.d[2][1]

    wf.add_side([3,2], 5)
    assert_equal 5, wf.d[2][3]
    assert_equal 5, wf.d[3][2]
  end

  def test_calc_shortest_paths
    wf = WarshallFloyd.new(5)
    wf.add_side([1,2], 4)
    wf.add_side([1,4], 1)
    wf.add_side([2,4], 1)
    wf.add_side([2,3], 3)
    wf.add_side([3,4], 1)
    wf.add_side([3,5], 2)
    wf.add_side([4,5], 5)

    wf.calc_shortest_paths

    assert_equal 2, wf.d[1][2]
    assert_equal 2, wf.d[2][1]
    assert_equal 2, wf.d[1][3]
    assert_equal 2, wf.d[3][1]
    assert_equal 1, wf.d[1][4]
    assert_equal 4, wf.d[1][5]
    assert_equal 4, wf.d[2][5]
    assert_equal 2, wf.d[3][5]
    assert_equal 3, wf.d[4][5]
  end
end
