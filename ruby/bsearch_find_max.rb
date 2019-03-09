def bsearch_find_max(array,x)
  array[bsearch_index_find_max(array, x)]
end

def bsearch_index_find_max(array, x)
  return nil if array.empty?
  return array.size - 1 if array.last <= x
  index = array.bsearch_index{|a| a > x}
  return nil if index.nil? || index.zero?
  index = index - 1
end

require 'minitest/autorun'

class TestBsearch < MiniTest::Test
  def setup
    @array1 = [10,20,30,40,50]
  end

  def test_bsearch_index_find_max_with_normal_case
    assert_equal 0, bsearch_index_find_max(@array1, 11)
    assert_equal 1, bsearch_index_find_max(@array1, 25)
    assert_equal 2, bsearch_index_find_max(@array1, 31)
    assert_equal 3, bsearch_index_find_max(@array1, 49)
    assert_equal 4, bsearch_index_find_max(@array1, 51)
  end

  def test_bsearch_index_find_max_with_corner_case
    assert_nil bsearch_index_find_max(@array1, -999)
    assert_nil bsearch_index_find_max(@array1, -1)
    assert_nil bsearch_index_find_max(@array1, 0)
    assert_nil bsearch_index_find_max(@array1, 9)
    assert_equal 0, bsearch_index_find_max(@array1, 10)
    assert_equal 1, bsearch_index_find_max(@array1, 20)
    assert_equal 2, bsearch_index_find_max(@array1, 30)
    assert_equal 3, bsearch_index_find_max(@array1, 40)
    assert_equal 4, bsearch_index_find_max(@array1, 50)
    assert_equal 4, bsearch_index_find_max(@array1, 1000)
    assert_equal 4, bsearch_index_find_max(@array1, Float::INFINITY)
  end

  def test_bsearch_index_find_max_with_one_elem_array
    array = [10]
    assert_nil bsearch_index_find_max(array, -1)
    assert_nil bsearch_index_find_max(array, 1)
    assert_nil bsearch_index_find_max(array, 9)
    assert_equal 0, bsearch_index_find_max(array, 10)
    assert_equal 0, bsearch_index_find_max(array, 11)
  end

  def test_bsearch_index_find_max_with_empty_array
    assert_nil bsearch_index_find_max([], -1)
    assert_nil bsearch_index_find_max([], 1)
    assert_nil bsearch_index_find_max([], 10)
  end

  def test_bsearch_index_find_max_with_dup_elems_array
    array = [20,20,20,30,30,30,40,40,40]
    assert_equal 2, bsearch_index_find_max(array, 20)
    assert_equal 2, bsearch_index_find_max(array, 29)
    assert_equal 5, bsearch_index_find_max(array, 30)
    assert_equal 5, bsearch_index_find_max(array, 39)
    assert_equal 8, bsearch_index_find_max(array, 40)
    assert_equal 8, bsearch_index_find_max(array, 99999)
  end
end
