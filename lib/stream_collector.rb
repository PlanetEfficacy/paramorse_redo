require_relative 'queue.rb'
module ParaMorse
  class StreamDecoder
    def initialize
      @code_queue = ParaMorse::Queue.new
      @letter_queue = ParaMorse::Queue.new
    end

    def push(data)
      @code_queue.push(data)
    end

    def peek
      @code_queue.peek
    end

    def receive(bit)
      @code_queue.push(bit)
    end

    def detect_character
      depth = 3
      result = @code_queue.peek(depth)
      until result.join.include?('000')
        depth += 1
        result = @code_queue.peek(depth)
      end
      return result.join.split('000')
    end
  end
end
