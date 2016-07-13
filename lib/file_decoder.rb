require './lib/sentence_decoder'
module ParaMorse
  class FileDecoder

    def decode(input, output)
      input_file = File.open(input)
      input_text = input_file.read
      input_file.close
      sentence_decoder = ParaMorse::SentenceDecoder.new
      decoded_text = sentence_decoder.decode(input_text)
      output_file = File.open(output, 'w')
      output_file.write(decoded_text)
    end
  end
end
