require "./lib/stream_decoder"

module ParaMorse
  class ParallelStreams
    attr_reader :streams

    def initialize(n)
      @streams = []
      n.times do
        @streams << ParaMorse::StreamDecoder.new
      end
    end

    def count
      @streams.length
    end
  end
end
