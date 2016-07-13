require './test/test_helper'
require './lib/parallel_encoder.rb'

class ParallelEncoderTest < Minitest::Test
  def test_parallel_encoder_exists
    parallel_encoder = ParaMorse::ParallelEncoder.new
    assert_instance_of ParaMorse::ParallelEncoder, parallel_encoder
  end

  def test_parallel_encoder_has_encode_from_file
    parallel_encoder = ParaMorse::ParallelEncoder.new
    assert_respond_to(parallel_encoder, :encode_from_file)
  end

  def test_parallel_encoder_has_a_stream_decoder
    parallel_encoder = ParaMorse::ParallelEncoder.new
    assert_respond_to(parallel_encoder, :stream)
    assert_instance_of ParaMorse::StreamDecoder, parallel_encoder.stream
  end

  def test_stream_file
    parallel_encoder = ParaMorse::ParallelEncoder.new
    expected = ["h","e","l","l","o"," ","w","o","r","l","d"]

    actual = parallel_encoder.stream_file("./morse_code_text/parallel_text1.txt")

    assert_equal expected, actual
  end

  def test_it_can_split_the_stream
    parallel_encoder = ParaMorse::ParallelEncoder.new
    parallel_encoder.stream_file("./morse_code_text/parallel_text1.txt")
    #expected = { "output1.txt" => "hlowrd", "output2.txt" => "el ol" }
    expected = { "output1.txt" => "10101010001011101010001110111011100010111011100010111010001110101", "output2.txt" => "100010111010100000000000011101110111000101110101" }

    actual = parallel_encoder.split(2)

    assert_equal expected, actual
  end

  def test_parallel_encoder_can_encode_from_file
    skip
    parallel_encoder = ParaMorse::ParallelEncoder.new
    expected = ""
    actual = parallel_encoder('parallel_input.txt', 8, 'parallel_output*.txt')

    assert_equal expected, actual
  end
end
