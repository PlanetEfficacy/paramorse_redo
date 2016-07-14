require './test/test_helper'
require './lib/file_encoder.rb'

class FileEncoderTest < Minitest::Test

  def test_file_encoder_exists
    file_enc = ParaMorse::FileEncoder.new
    assert_instance_of ParaMorse::FileEncoder, file_enc
  end

  def test_file_encoder_has_encode
    file_enc = ParaMorse::FileEncoder.new
    assert_respond_to(file_enc, :encode)
  end

  def test_file_encoder_has_read
    file_enc = ParaMorse::FileEncoder.new
    assert_respond_to(file_enc, :read)
  end

  def test_file_encoder_reads_in_file_to_string_output
    file_enc = ParaMorse::FileEncoder.new
    expected = "hello world"
    actual = file_enc.read("./morse_code_text/parallel_text1.txt")
  end

  def test_file_encoder_has_write
    file_enc = ParaMorse::FileEncoder.new
    assert_respond_to(file_enc, :write)
  end

  def test_file_encoder_writes_string_to_file_output
    file_enc = ParaMorse::FileEncoder.new
    expected = 11
    actual = file_enc.write("hello world", "./morse_code_text/parallel_text1_test_write.txt")
    assert_equal expected, actual
  end

  def test_file_encoder_can_encode

    file_enc = ParaMorse::FileEncoder.new
    expected = 164235
    actual = file_enc.encode("./morse_code_text/morse_code_text1.txt", "./morse_code_text/morse_code_obama_speech_encoded.txt")

    assert_equal expected, actual
  end

  def test_file_encoder_can_encode_again

    file_enc = ParaMorse::FileEncoder.new
    expected = 111
    actual = file_enc.encode("./morse_code_text/parallel_text1.txt", "./morse_code_text/parallel_text1_encoded.txt")

    assert_equal expected, actual
  end
end
