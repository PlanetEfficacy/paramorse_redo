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

  end

end
