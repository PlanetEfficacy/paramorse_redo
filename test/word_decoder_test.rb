# require 'SimpleCov'
# SimpleCov.start
require 'minitest/autorun'
require 'minitest/pride'

require_relative '../lib/word_decoder.rb'

class WordDecoderTest < Minitest::Test
  def test_it_encodes_words
    word_decoder = ParaMorse::WordDecoder.new
    assert_equal "word", word_decoder.decode("1011101110001110111011100010111010001110101")
  end
end
