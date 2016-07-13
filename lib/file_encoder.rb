require './lib/sentence_encoder'
module ParaMorse
  class FileEncoder

    def encode(input, output)
      sentence_encoder = ParaMorse::SentenceEncoder.new
      input_text = read(input)
      encoded_text = sentence_encoder.encode(input_text)
      write(encoded_text, output)
    end

    def read(input)
      input_file = File.open(input)
      input_text = input_file.read
      input_file.close
      return input_text
    end

    def write(output_string, output_file)
      output = File.open(output_file, 'w')
      output.write(output_string)
    end

  end
end
