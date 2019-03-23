def delete_first(array, char)
  index = array.index(char)
  return nil if index.nil?
  array.delete_at(index)
end

require 'minitest/autorun'

class TestDeleteFirst < MiniTest::Test
  def test_delete_first
    array1 = ["a","a","b"]

    delete_first(array1, "c")
    assert_equal ["a","a","b"], array1

    delete_first(array1, "a")
    assert_equal ["a","b"], array1

    array2 = ["a","b"]
    delete_first(array2, "b")
    assert_equal ["a"], array2

    array3 = []
    delete_first(array3, "a")
    assert_equal [], array3
  end
end
