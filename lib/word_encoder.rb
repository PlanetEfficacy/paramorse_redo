require './lib/letter_encoder.rb'
module ParaMorse
  class WordEncoder
    def initialize
      @letter_encoder = ParaMorse::LetterEncoder.new
    end

    def encode(word)
      morse_code = word.chars.map do |letter|
        @letter_encoder.encode(letter)
      end
      morse_code.join('000')
    end

    
  end
end
