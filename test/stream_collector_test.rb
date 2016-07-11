require 'SimpleCov'
SimpleCov.start
require 'minitest/autorun'
require 'minitest/pride'

require_relative '../lib/stream_collector.rb'

class StreamDecoderTest < Minitest::Test
  def test_it_collects_code
    collector = ParaMorse::StreamDecoder.new
    assert_respond_to collector, :push
  end

  def test_it_collects_letter
    skip
    collector = ParaMorse::StreamDecoder.new
    collector.push("1")
    collector.push("0")
    assert_equal ["1", "0"], collector.read
  end

  def test_it_can_see_letters_with_peek
    collector = ParaMorse::StreamDecoder.new
    letter = ["0","1"].sample
    collector.push(letter)
    assert_equal letter, collector.peek
  end

  def test_it_can_find_letters_from_streams_of_bits
    stream = ParaMorse::StreamDecoder.new


    stream.receive("1")
    stream.receive("0")
    stream.receive("1")
    stream.receive("0")
    stream.receive("1")
    stream.receive("0")
    stream.receive("1")
    stream.receive("0")
    stream.receive("0")
    stream.receive("0")

    assert_equal "1010101", stream.detect_character
  end

  def test_it_can_find_character_from_random_letter
    stream = ParaMorse::StreamDecoder.new
    bin_letters = []
    3.times do
      bin_letters << ["11101011101", "1110101", "1"].sample
    end
    joined_letters = bin_letters.join("000")
    joined_letters.chars.each do |bit|
      stream.receive(bit)
    end
    assert_equal bin_letters, stream.detect_character
  end


  def test_is_bad
    skip
    stream.receive("1")
    stream.receive("0")
    stream.receive("1")
    stream.receive("0")
    assert_equal "hi", stream.decode
  end
end
