require 'pry'
module ParaMorse
  class Queue
    attr_reader :queue

    def initialize()
      @queue = []
    end
    def push(incoming_bit)
        @queue.push(incoming_bit)
    end

    def peek(quantity = 1)
      quantity == 1 ? @queue.first : @queue[0..quantity - 1]
    end

    def tail(quantity = 1)
      quantity == 1 ? @queue.last : @queue[-quantity .. -1].reverse
    end

    def pop(quantity = 1)
      quantity == 1 ? @queue.shift : @queue.shift(quantity)
    end
    def count
      @queue.size
    end

    def clear
      @queue = []
    end
  end
end
