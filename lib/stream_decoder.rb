require "./lib/queue"
require "./lib/word_decoder"
require "./lib/word_encoder"
module ParaMorse
  class StreamDecoder
    attr_reader :queue

    def initialize
      @queue = ParaMorse::Queue.new
    end

    def receive(digit)
      @queue.push(digit)
      # if has_morse_character?
      #   morse_character = pop_morse_character
      #
      #   #decode(pop_morse_character)
      # end
    end

    def pop_morse_character
      case
      when has_trailing_0s?
        character = pop_morse_character_from_trailing_0s
      when has_leading_0s?
        character = pop_morse_character_from_leading_0s
      end
      stringify(character)
    end

    def pop_morse_character_from_trailing_0s
      length = queue.count
      character = @queue.pop(length-3)
      @queue.pop(3)
      return character
    end

    def pop_morse_character_from_leading_0s
      length = queue.count
      character = @queue.pop(length-1)
    end

    def decode(morse_code = @queue.queue.join)
      sentence_decoder = ParaMorse::WordDecoder.new
      sentence_decoder.decode(morse_code)
    end

    def encode
      sentence_encoder = ParaMorse::WordEncoder.new
      morse_code = @queue.queue.join
      sentence_encoder.encode(morse_code)
    end

    def has_morse_character?
      digits = @queue.peek(@queue.count)
      return false if digits.length == 1
      digits.join.include?("1000") || digits.join.include?("0001")
    end

    def has_trailing_0s?
      inspect.include?("1000")
    end

    def has_leading_0s?
      inspect.include?("0001")
    end

    def inspect
      return @queue.peek(@queue.count).join if @queue.count > 1
      return @queue.queue[0] if @queue.count == 1
      return "" if @queue.count < 1
    end

    def stringify(array)
      if array.length > 1
        array.join('')
      elsif array.length == 1
        array[0]
      else
        array
      end
    end

  end

end
