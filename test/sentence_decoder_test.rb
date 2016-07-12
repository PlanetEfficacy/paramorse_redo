require './test/test_helper'
require './lib/sentence_decoder.rb'

class SentenceDecoderTest < Minitest::Test
  def test_it_decodes_sentences
    decoder = ParaMorse::SentenceDecoder.new
    expected = "word word word"
    actual = decoder.decode("10111011100011101110111000101110100011101010000000101110111000111011101110001011101000111010100000001011101110001110111011100010111010001110101")
    assert_equal expected, actual
  end

  def test_it_can_still_decode_words
    decoder = ParaMorse::SentenceDecoder.new
    expected = "word"
    actual = decoder.decode("1011101110001110111011100010111010001110101")
    assert_equal expected, actual
  end
end
