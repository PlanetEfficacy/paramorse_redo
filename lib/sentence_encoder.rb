require_relative "word_encoder.rb"
module ParaMorse
  class SentenceEncoder
    def initialize
      @word_encoder = ParaMorse::WordEncoder.new
    end

    def encode(sentence)
      words = sentence.split(" ")
      morse_code = words.map do |word|
        @word_encoder.encode(word)
      end
      morse_code.join("0000000")
    end
  end
end
