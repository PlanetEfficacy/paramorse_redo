require './test/test_helper'
require './lib/word_decoder.rb'

class WordDecoderTest < Minitest::Test
  def test_it_encodes_words
    word_decoder = ParaMorse::WordDecoder.new
    assert_equal "word", word_decoder.decode("1011101110001110111011100010111010001110101")
  end

  def test_it_encodes_other_words
    word_decoder = ParaMorse::WordDecoder.new
    assert_equal "hi", word_decoder.decode("10101010001010")
  end
end
