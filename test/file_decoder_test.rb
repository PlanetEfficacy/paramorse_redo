require './test/test_helper'
require './lib/file_decoder.rb'

class FileDecoderTest < Minitest::Test

  def test_file_decoder_exists
    file_dec = ParaMorse::FileDecoder.new
    assert_instance_of ParaMorse::FileDecoder, file_dec
  end

  def test_file_has_decode
    file_dec = ParaMorse::FileDecoder.new
    assert_respond_to(file_dec, :decode)
  end

  def test_file_can_decode
    file_dec = ParaMorse::FileDecoder.new
    expected = 20100
    actual = file_dec.decode("./morse_code_text/morse_code_text1_encoded.txt", "./morse_code_text/morse_code_obama_speech_decoded.txt", )

    assert_equal expected, actual
  end
end
