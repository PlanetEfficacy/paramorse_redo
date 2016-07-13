require './test/test_helper'
require './lib/split_stream.rb'

class SplitStreamTest < Minitest::Test

  def test_it_is_a_split_stream
    s = ParaMorse::SplitStream.new("00", "output00.txt", "hlowrd", "10101010001011101010001110111011100010111011100010111010001110101")
    expected1 = "00"
    expected2 = "output00.txt"
    expected3 = "hlowrd"
    expected4 = "10101010001011101010001110111011100010111011100010111010001110101"

    actual1 = s.stream_number
    actual2 = s.file_name
    actual3 = s.input_text
    actual4 = s.output_text

    assert_equal expected1, actual1
    assert_equal expected2, actual2
    assert_equal expected3, actual3
    assert_equal expected4, actual4
  end
end
