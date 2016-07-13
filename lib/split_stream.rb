require "./lib/stream_decoder"

module ParaMorse
  class SplitStream
      attr_reader :stream_number,
                  :file_name,
                  :input_text,
                  :output_text

    def initialize(stream_number, file_name, input_text, output_text)
      @stream_number = stream_number
      @file_name = file_name
      @input_text = input_text
      @output_text = output_text
    end

  end

end
