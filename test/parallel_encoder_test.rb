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

  def test_it_knows_which_stream
    parallel_encoder = ParaMorse::ParallelEncoder.new
    expected1 = "00"
    expected2 = "01"
    expected3 = "02"
    expected4 = "03"
    expected5 = "04"
    expected6 = "05"
    expected7 = "06"
    expected8 = "07"

    actual1 = parallel_encoder.which_stream(0, 8)
    actual2 = parallel_encoder.which_stream(1, 8)
    actual3 = parallel_encoder.which_stream(2, 8)
    actual4 = parallel_encoder.which_stream(3, 8)
    actual5 = parallel_encoder.which_stream(4, 8)
    actual6 = parallel_encoder.which_stream(5, 8)
    actual7 = parallel_encoder.which_stream(6, 8)
    actual8 = parallel_encoder.which_stream(7, 8)

    assert_equal expected1, actual1
    assert_equal expected2, actual2
    assert_equal expected3, actual3
    assert_equal expected4, actual4
    assert_equal expected5, actual5
    assert_equal expected6, actual6
    assert_equal expected7, actual7

  end

  def test_it_can_make_file_names
    parallel_encoder = ParaMorse::ParallelEncoder.new
    output_file_name = "output*.txt"
    streamid1 = "00"
    streamid2 = "01"
    expected1 = "output00.txt"
    expected2 = "output01.txt"

    actual1 = parallel_encoder.create_file_name(streamid1, output_file_name)
    actual2 = parallel_encoder.create_file_name(streamid2, output_file_name)

    assert_equal expected1, actual1
    assert_equal expected2, actual2
  end

  def test_it_converts_to_morse
    parallel_encoder = ParaMorse::ParallelEncoder.new
    expected = "1010101"
    actual = parallel_encoder.convert_to_morse("h")

    assert_equal expected, actual
  end

  def test_it_knows_if_the_stream_already_exists
    parallel_encoder = ParaMorse::ParallelEncoder.new
    split_stream1 = ParaMorse::SplitStream.new("00", "output00.txt", "hlowrd", "10101010001011101010001110111011100010111011100010111010001110101")
    split_stream2 = ParaMorse::SplitStream.new("01", "output01.txt", "el ol", "1000101110101000000000000011101110111000101110101")
    results = []
    results2 = [split_stream1, split_stream2]

    actual = parallel_encoder.stream_exists?("00", results)
    actual1 = parallel_encoder.stream_exists?("10", results)
    actual2 = parallel_encoder.stream_exists?("00", results2)
    actual3 = parallel_encoder.stream_exists?("01", results2)
    actual4 = parallel_encoder.stream_exists?("03", results2)

    refute actual
    refute actual1
    assert actual2
    assert actual3
    refute actual4
  end

  def test_it_can_make_a_split_stream
    parallel_encoder = ParaMorse::ParallelEncoder.new
    expected1 = "output00.txt"
    expected2 = "h"
    expected3 = "1010101"
    expected4 = "00"
    actual = parallel_encoder.create_split_stream("00", "output*.txt", "h", "1010101")
    actual1 = actual.file_name
    actual2 = actual.input_text
    actual3 = actual.output_text
    actual4 = actual.stream_number

    assert_instance_of ParaMorse::SplitStream, actual
    assert_equal expected1, actual1
    assert_equal expected2, actual2
    assert_equal expected3, actual3
    assert_equal expected4, actual4
  end

  def test_it_can_find_a_split_stream
    parallel_encoder = ParaMorse::ParallelEncoder.new
    split_stream1 = ParaMorse::SplitStream.new("00", "output00.txt", "h", "1010101")
    split_stream2 = ParaMorse::SplitStream.new("01", "output01.txt", "i", "101")
    results = [split_stream1, split_stream2]
    expected1 = split_stream1
    expected2 = split_stream2
    expected3 = nil
    expected4 = nil

    actual1 = parallel_encoder.find_stream("00", results)
    actual2 = parallel_encoder.find_stream("01", results)
    actual3 = parallel_encoder.find_stream("03", results)
    actual4 = parallel_encoder.find_stream("10", results)


    assert_equal expected1, actual1
    assert_equal expected2, actual2
    assert_equal expected3, actual3
    assert_equal expected4, actual4
  end

  def test_it_can_split_the_stream
    parallel_encoder = ParaMorse::ParallelEncoder.new
    parallel_encoder.stream_file("./morse_code_text/parallel_text1.txt")
    split_stream1 = ParaMorse::SplitStream.new("00", "output00.txt", "hlowrd", "10101010001011101010001110111011100010111011100010111010001110101")
    split_stream2 = ParaMorse::SplitStream.new("01", "output01.txt", "el ol", "1000101110101000000000000011101110111000101110101")
    expected1 = split_stream1.stream_number
    expected2 = split_stream1.file_name
    expected3 = split_stream1.input_text
    expected4 = split_stream1.output_text
    expected5 = split_stream2.stream_number
    expected6 = split_stream2.file_name
    expected7 = split_stream2.input_text
    expected8 = split_stream2.output_text

    results = parallel_encoder.split(2, "output*.txt")
    actual1 = results[0].stream_number
    actual2 = results[0].file_name
    actual3 = results[0].input_text
    actual4 = results[0].output_text
    actual5 = results[1].stream_number
    actual6 = results[1].file_name
    actual7 = results[1].input_text
    actual8 = results[1].output_text

    assert_equal expected1, actual1
    assert_equal expected2, actual2
    assert_equal expected3, actual3
    assert_equal expected4, actual4
    assert_equal expected5, actual5
    assert_equal expected6, actual6
    assert_equal expected7, actual7
    assert_equal expected8, actual8
  end

  def test_parallel_encoder_can_encode_from_file
    parallel_encoder = ParaMorse::ParallelEncoder.new
    split_stream1 = ParaMorse::SplitStream.new("00", "./morse_code_text/parallel_encode_from_file_output00.txt", "hlowrd", "10101010001011101010001110111011100010111011100010111010001110101")
    split_stream2 = ParaMorse::SplitStream.new("01", "./morse_code_text/parallel_encode_from_file_output01.txt", "el ol", "1000101110101000000000000011101110111000101110101")
    expected = [split_stream1, split_stream2]
    expected1 = split_stream1.stream_number
    expected2 = split_stream1.file_name
    expected3 = split_stream1.input_text
    expected4 = split_stream1.output_text
    expected5 = split_stream2.stream_number
    expected6 = split_stream2.file_name
    expected7 = split_stream2.input_text
    expected8 = split_stream2.output_text

    results = parallel_encoder.encode_from_file('./morse_code_text/parallel_text1.txt', 2, './morse_code_text/parallel_encode_from_file_output*.txt')
    actual1 = results[0].stream_number
    actual2 = results[0].file_name
    actual3 = results[0].input_text
    actual4 = results[0].output_text
    actual5 = results[1].stream_number
    actual6 = results[1].file_name
    actual7 = results[1].input_text
    actual8 = results[1].output_text

    assert_equal expected1, actual1
    assert_equal expected2, actual2
    assert_equal expected3, actual3
    assert_equal expected4, actual4
    assert_equal expected5, actual5
    assert_equal expected6, actual6
    assert_equal expected7, actual7
    assert_equal expected8, actual8
  end


  def test_it_can_write_all_the_streams
    parallel_encoder = ParaMorse::ParallelEncoder.new
    split_stream1 = ParaMorse::SplitStream.new("00", "./morse_code_text/output00.txt", "hlowrd", "10101010001011101010001110111011100010111011100010111010001110101")
    split_stream2 = ParaMorse::SplitStream.new("01", "./morse_code_text/output01.txt", "el ol", "100010111010100000000000011101110111000101110101")
    results = [split_stream1, split_stream2]
    expected1 = "10101010001011101010001110111011100010111011100010111010001110101"
    expected2 = "100010111010100000000000011101110111000101110101"

    actual_results = parallel_encoder.write_all_the_streams(results)
    actual1 = actual_results[0]
    actual2 = actual_results[1]

    assert_equal expected1.length, actual1
    assert_equal expected2.length, actual2
  end

  def test_it_can_encode_from_a_bigger_file_with_more_streams
    parallel_encoder = ParaMorse::ParallelEncoder.new
    input_file = "./morse_code_text/morse_code_obama_speech_decoded.txt"
    output_file = "./morse_code_text/obama_output*.txt"
    stream_count = 8
    input_file_handler = File.open(input_file)
    speech_text = input_file_handler.read
    every_eighth_char = speech_text.each_char.with_index.map do |char, index|
      return char if index % stream_count == 0
    end

    actual_results = parallel_encoder.encode_from_file(input_file, stream_count, output_file)
    split_stream0 = actual_results.find do |split_stream|
      split_stream.stream_number == 0
    end
    actual1 = split_stream0.output_text

    assert_equal expected1.length, actual1.length
    assert_equal expected1, actual1
  end

end
