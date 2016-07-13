require './test/test_helper'
require './lib/file_encoder.rb'

class FileEncoderTest < Minitest::Test

  def test_file_encoder_exists
    file_enc = ParaMorse::FileEncoder.new
    assert_instance_of ParaMorse::FileEncoder, file_enc
  end

  def test_file_has_encode
    file_enc = ParaMorse::FileEncoder.new
    assert_respond_to(file_enc, :encode)
  end

  def test_file_can_encode
    file_enc = ParaMorse::FileEncoder.new
    expected = 164235
    actual = file_enc.encode("./morse_code_text/morse_code_text1.txt", "./morse_code_text/morse_code_obama_speech_encoded.txt")

    assert_equal expected, actual
  end
end
