require './test/test_helper'
require './lib/stream_decoder.rb'

class StreamTest < Minitest::Test

  def test_it_has_a_queue
    s = ParaMorse::StreamDecoder.new
    expected = 0
    actual = s.queue.count

    assert_equal expected, actual
  end

  def test_it_can_recieve
    s = ParaMorse::StreamDecoder.new
    broadcast = "10101010001010"

    expected = broadcast.length
    broadcast.each_char do |digit|
      s.receive(digit)
    end
    actual = s.queue.count

    assert_equal expected, actual
  end

  def test_it_can_decode_letter
    s = ParaMorse::StreamDecoder.new
    s2 = ParaMorse::StreamDecoder.new
    broadcast = "1010101"
    expected = "h"
    broadcast2 = "1010"
    expected2 = "i"
    broadcast.each_char do |digit|
      s.receive(digit)
    end
    broadcast2.each_char do |digit|
      s2.receive(digit)
    end

    actual = s.decode
    actual2 = s2.decode

    assert_equal expected, actual
    assert_equal expected2, actual2
  end

  def test_it_can_decode_word
    s = ParaMorse::StreamDecoder.new
    s2 = ParaMorse::StreamDecoder.new
    broadcast = "10101010001010"
    broadcast2 = "1011101110001110111011100010111010001110101"
    expected = "hi"
    expected2 = "word"

    broadcast.each_char do |digit|
      s.receive(digit)
    end
    actual = s.decode
    broadcast2.each_char do |digit|
      s2.receive(digit)
    end
    actual2 = s2.decode

    assert_equal expected, actual
    assert_equal expected2, actual2
  end

  def test_it_can_encode_word
    s = ParaMorse::StreamDecoder.new
    s2 = ParaMorse::StreamDecoder.new
    broadcast = "hi"
    broadcast2 = "word"
    expected = "1010101000101"
    expected2 = "1011101110001110111011100010111010001110101"

    broadcast.each_char do |digit|
      s.receive(digit)
    end
    actual = s.encode
    broadcast2.each_char do |digit|
      s2.receive(digit)
    end
    actual2 = s2.encode

    assert_equal expected, actual
    assert_equal expected2, actual2
  end

  def test_it_knows_if_it_has_a_morse_character
    s1 = ParaMorse::StreamDecoder.new
    s2 = ParaMorse::StreamDecoder.new
    s3 = ParaMorse::StreamDecoder.new
    broadcast1 = "1010101000"
    broadcast2 = "1000" #101110101"
    broadcast3 = "00000000000001" #"1101110111000101110101"
    expected_broadcast1_results = [false, false, false, false, false, false, false, false, false, true]
    expected_broadcast2_results = [false, false, false, true]
    expected_broadcast3_results = [false, false, false, false, false, false, false, false, false, false, false, false, false, true]
    actual_broadcast1_results = []
    actual_broadcast2_results = []
    actual_broadcast3_results = []

    broadcast1.each_char do |digit|
      s1.receive(digit)
      actual_broadcast1_results << s1.has_morse_character?
    end
    broadcast2.each_char do |digit|
      s2.receive(digit)
      actual_broadcast2_results << s2.has_morse_character?
    end
    broadcast3.each_char do |digit|
      s3.receive(digit)
      actual_broadcast3_results << s3.has_morse_character?
    end

    assert_equal expected_broadcast1_results, actual_broadcast1_results
    assert_equal expected_broadcast2_results, actual_broadcast2_results
    assert_equal expected_broadcast3_results, actual_broadcast3_results

  end

  def test_it_can_pop_a_morse_character_from_trailing_0s
    s1 = ParaMorse::StreamDecoder.new
    broadcast1 = "1010101000"
    expected1 = "1010101"
    expected2 = ""

    broadcast1.each_char do |digit|
      s1.receive(digit)
    end

    actual1 = s1.pop_morse_character_from_trailing_0s
    actual2 = s1.inspect
  end

  def test_it_can_pop_a_morse_character_from_leading_0s
    s1 = ParaMorse::StreamDecoder.new
    broadcast1 = "00000000000001"
    expected1 = "0000000000000"
    expected2 = "1"

    broadcast1.each_char do |digit|
      s1.receive(digit)
    end

    actual1 = s1.pop_morse_character_from_leading_0s
    actual2 = s1.inspect

  end

  def test_it_can_pop_a_morse_character

    s1 = ParaMorse::StreamDecoder.new
    s2 = ParaMorse::StreamDecoder.new
    s3 = ParaMorse::StreamDecoder.new
    broadcast1 = "1010101000"
    broadcast2 = "1000"
    broadcast3 = "00000000000001"
    expected1 = "1010101"
    expected2 = ""
    expected3 = "1"
    expected4 = ""
    expected5 = "0000000000000"
    expected6 = "1"

    broadcast1.each_char do |digit|
      s1.receive(digit)
    end
    broadcast2.each_char do |digit|
      s2.receive(digit)
    end
    broadcast3.each_char do |digit|
      s3.receive(digit)
    end

    actual1 = s1.pop_morse_character
    actual2 = s1.inspect
    actual3 = s2.pop_morse_character
    actual4 = s2.inspect
    actual5 = s3.pop_morse_character
    actual6 = s3.inspect

    assert_equal expected1, actual1
    assert_equal expected2, actual2
    assert_equal expected3, actual3
    assert_equal expected4, actual4
    assert_equal expected5, actual5
    assert_equal expected6, actual6

  end

  def test_it_detects_trailing_0s
    s1 = ParaMorse::StreamDecoder.new
    s2 = ParaMorse::StreamDecoder.new
    s3 = ParaMorse::StreamDecoder.new
    broadcast1 = "1010101000"
    broadcast2 = "1000"
    broadcast3 = "00000000000001"

    broadcast1.each_char do |digit|
      s1.receive(digit)
    end
    broadcast2.each_char do |digit|
      s2.receive(digit)
    end
    broadcast3.each_char do |digit|
      s3.receive(digit)
    end

    actual1 = s1.has_trailing_0s?
    actual2 = s2.has_trailing_0s?
    actual3 = s3.has_trailing_0s?

    assert actual1
    assert actual2
    refute actual3

  end

  def test_it_detects_leading_0s
    s1 = ParaMorse::StreamDecoder.new
    s2 = ParaMorse::StreamDecoder.new
    s3 = ParaMorse::StreamDecoder.new
    broadcast1 = "1010101000"
    broadcast2 = "1000"
    broadcast3 = "00000000000001"

    broadcast1.each_char do |digit|
      s1.receive(digit)
    end
    broadcast2.each_char do |digit|
      s2.receive(digit)
    end
    broadcast3.each_char do |digit|
      s3.receive(digit)
    end

    actual1 = s1.has_leading_0s?
    actual2 = s2.has_leading_0s?
    actual3 = s3.has_leading_0s?

    refute actual1
    refute actual2
    assert actual3

  end

  def test_it_can_inspect
    s1 = ParaMorse::StreamDecoder.new
    s2 = ParaMorse::StreamDecoder.new
    broadcast1 = "1010101000"
    expected = broadcast1
    broadcast2 = ""
    expected2 = broadcast2
    broadcast1.each_char do |digit|
      s1.receive(digit)
    end
    broadcast2.each_char do |digit|
      s2.receive(digit)
    end

    actual = s1.inspect
    actual2 = s2.inspect

    assert_equal expected, actual
    assert_equal expected2, actual2
  end

  def test_it_decodes_when_it_has_a_morse_character
    skip
    s1 = ParaMorse::StreamDecoder.new
    s2 = ParaMorse::StreamDecoder.new
    s3 = ParaMorse::StreamDecoder.new
    broadcast1 = "1010101000"
    broadcast2 = "1000"
    broadcast3 = "00000000000001"
    expected1 = "h"
    expected2 = "e"
    expected3 = " "
    actual1 = ""
    actual2 = ""
    actual3 = ""

    broadcast1.each_char do |digit|
      actual1 = s1.receive(digit)
    end
    broadcast2.each_char do |digit|
      actual2 = s2.receive(digit)
    end
    broadcast3.each_char do |digit|
      actual3 = s3.receive(digit)
    end

    assert_equal expected1, actual1
    assert_equal expected2, actual2
    assert_equal expected3, actual3

  end

  def test_stringify
    s1 = ParaMorse::StreamDecoder.new
    array1 = ["1", "0", "1", "0", "1", "0", "1"]
    array2 = ["1"]
    expected1 = "1010101"
    expected2 = "1"

    actual1 = s1.stringify(array1)
    actual2 = s1.stringify(array2)

    assert_equal expected1, actual1
    assert_equal expected2, actual2
  end


end
