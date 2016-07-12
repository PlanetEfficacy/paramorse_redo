require "./lib/queue"
require "./lib/word_decoder"
module ParaMorse
  class StreamDecoder
    attr_reader :queue

    def initialize
      @queue = ParaMorse::Queue.new
    end

    def receive(digit)
      @queue.push(digit)
    end

    def decode
      sentence_decoder = ParaMorse::WordDecoder.new
      morse_code = @queue.queue.join
      sentence_decoder.decode(morse_code)
    end

  end
end
