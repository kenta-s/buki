require 'prime'

# 約数の個数を求めたいならこれじゃなくて公式を使って！
def common_divisors(n)
  return [1] if n == 1

  tmp = n.prime_division.map do |e|
    (0..e[1]).to_a.map do |i|
      e[0]**i
    end
  end
    
  tmp.reduce{|p,q| p.product(q)}.map do |a|
    [a].flatten.reduce(&:*)
  end.sort
end

require 'minitest/autorun'
class TestCommonDivisors < MiniTest::Test
  def test_common_divisors
    assert_equal [1], common_divisors(1)
    assert_equal [1,7], common_divisors(7)
    assert_equal [1,3,5,15,149,447,745,2235], common_divisors(2235)
  end
end
