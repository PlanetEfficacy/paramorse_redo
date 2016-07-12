# require 'SimpleCov'
# SimpleCov.start
require 'minitest/autorun'
require 'minitest/pride'

require_relative '../lib/word_encoder.rb'

class WordEncoderTest < Minitest::Test
  def test_it_encodes_words
    encoder = ParaMorse::WordEncoder.new
    assert_equal "1011101110001110111011100010111010001110101", encoder.encode("word")
  end
end
