require './lib/sentence_encoder'
module ParaMorse
  class FileEncoder

    def encode(input, output)
      input_file = File.open(input)
      input_text = input_file.read
      input_file.close
      sentence_encoder = ParaMorse::SentenceEncoder.new
      encoded_text = sentence_encoder.encode(input_text)
      output_file = File.open(output, 'w')
      output_file.write(encoded_text)
    # #Read in the file which gives us a string
    # #Pass the string to stream_decoder class
    # #make sure the return value stream_decoder is a decoded stream_decoder
    #   decoded_text
    #   File.write(output, decoded_text)
    #   #write result it to file
    end

    def write(decoded_text)

    end

  end
end
