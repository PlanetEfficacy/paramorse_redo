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
    expected = 557
    actual = file_enc.encode("./morse_code_text/morse_code_text1.txt", "./morse_code_text/morse_code_text1_encoded.txt")

    assert_equal expected, actual
    # file_enc.encode("plain.txt", "encoded.txt")
    #check the string before it writes in this test
    #assert that the return value of encode is the number of characters we are expecting
    #assert that the reading in the output file equals a string
  end

end
# "now is the time for all good men to come to the aid of their country"
# "11101000111011101110001011101110000000101000101010000000111000101010100010000000111000101000111011100010000000101011101000111011101110001011101000000010111000101110101000101110101000000011101110100011101110111000111011101110001110101000000011101110001000111010000000111000111011101110000000111010111010001110111011100011101110001000000011100011101110111000000011100010101010001000000010111000101000111010100000001110111011100010101110100000001110001010101000100010100010111010000000111010111010001110111011100010101110001110100011100010111010001110101110111"
# 557

# file_enc = ParaMorse::FileEncoder.new
# file_enc.encode("plain.txt", "encoded.txt")
# # => (output the length of the written file) - THIS IS THE NORMAL BEHAVIOR FOR



# # open the 'encoded.txt' file and verify that it's in morse
# file_dec = ParaMorse::FileDecoder.new
# file_dec.decode("encoded.txt", "plain_output.txt")
# # => (output the length of the written file)
# # open the "plain_output.txt" file and verify that it's in morse
