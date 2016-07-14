require "./lib/stream_decoder"
require "./lib/file_encoder"
require "./lib/split_stream"
require "./lib/letter_encoder"

module ParaMorse
  class ParallelEncoder
    attr_reader :stream

    def initialize
      @stream = StreamDecoder.new
    end

    def encode_from_file(input_file_name, stream_count, output_file_name)
      stream_file(input_file_name)
      split(stream_count, output_file_name)
    end

    def stream_file(input_file_name)
      file_encoder = FileEncoder.new
      input_text = file_encoder.read(input_file_name)
      input_text.split('').each do |character|
        @stream.receive(character) if character != "\n"
      end
      @stream.queue.queue
    end

    def split(stream_count, output_file_name)
      results = []
      queue = @stream.queue
      characters = queue.queue
      characters.each.with_index do |character, index|
        stream_number = which_stream(index, stream_count)
        input_text = character #queue.pop
        output_text = convert_to_morse(input_text)
        if !stream_exists?(stream_number, results)
          results << create_split_stream(stream_number, output_file_name, input_text, output_text)
        else
          this_stream = find_stream(stream_number, results)
          this_stream.input_text += character
          this_stream.output_text += "000" + output_text
        end
      end
      write_all_the_streams(results)
      return results
    end

    def write_all_the_streams(results)
      file_encoder = FileEncoder.new
      results.map do |split_stream|
        file_encoder.write(split_stream.output_text, split_stream.file_name)
      end
    end

    def create_split_stream(stream_number, output_file_name, input_text, output_text)
      file_name = create_file_name(stream_number, output_file_name)
      SplitStream.new(stream_number, file_name, input_text, output_text)
    end

    def which_stream(index, stream_count)
      stream = (index % stream_count).to_s
      stream.length == 1 ? "0" + stream : stream
    end

    def create_file_name(stream_number, output_file_name)
      output_file_name.sub("*", stream_number)
    end

    def convert_to_morse(letter)
      letter_encoder = LetterEncoder.new
      letter_encoder.encode(letter)
    end

    def stream_exists?(stream_number, results)
      stream = find_stream(stream_number, results)
      stream ? true : false
    end

    def find_stream(stream_number, results)
      return false if results.length == 0
      results.find do |split_stream|
        split_stream.stream_number == stream_number
      end
    end

  end
end
