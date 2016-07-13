require "./lib/stream_decoder"
require "./lib/file_encoder"

module ParaMorse
  class ParallelEncoder
    attr_reader :stream

    def initialize
      @stream = StreamDecoder.new
    end

    def encode_from_file(input_file_name, stream_count, output_file_name)
      stream_file(input_file_name)
    end

    def stream_file(input_file_name)
      file_encoder = FileEncoder.new
      input_text = file_encoder.read(input_file_name)
      input_text.split('').each do |character|
        @stream.receive(character) if character != "\n"
      end
      @stream.queue.queue
    end

    def split(stream_count)

    end





  end
end
# parallel_encoder = ParaMorse::ParallelEncoder.new
# parallel_encoder.encode_from_file('input.txt', 8, 'output*.txt')
# # generates eight different files
# # filenames are 'output00.txt', 'output01.txt'...'output07.txt'
# # contents of 'output00.txt' are every eighth character of input.txt
# # contents of 'output01.txt' are offset 1 then every eighth character of input.txt
# # ...
# # contents of 'output07.txt' are offset 7 then every eighth character of input.txt
# parallel_decoder = ParaMorse::ParallelDecoder.new
# parallel_decoder.decode_from_files(8, 'output*.txt', 'decoded.txt')
# # contents of all output*.txt files are merged into a single output file, decoded.txt
