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


  def test_parallel_encoder_can_encode_from_file
    skip
    parallel_encoder = ParaMorse::ParallelEncoder.new
    expected = ""
    actual = parallel_encoder('parallel_input.txt', 8, 'parallel_output*.txt')

    assert_equal expected, actual
  end
end
