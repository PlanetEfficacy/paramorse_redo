# require 'SimpleCov'
# SimpleCov.start
require 'minitest/autorun'
require 'minitest/pride'

require_relative '../lib/sentence_encoder.rb'

class SentenceEncoderTest < Minitest::Test
  def test_it_encodes_sentences
    encoder = ParaMorse::SentenceEncoder.new
    expected = "10111011100011101110111000101110100011101010000000101110111000111011101110001011101000111010100000001011101110001110111011100010111010001110101"
    actual = encoder.encode("word word word")
    assert_equal expected, actual
  end
end
