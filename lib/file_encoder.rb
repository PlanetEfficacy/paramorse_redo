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
    end
  end
end
