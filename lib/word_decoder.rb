require './lib/letter_decoder.rb'
require 'pry'
module ParaMorse
  class WordDecoder
    def initialize
      @letter_decoder = LetterDecoder.new
    end

    def decode(morse_code)
      letters = morse_code.split('000')
      word = letters.map do |letter|
        @letter_decoder.decode(letter)
      end
      word.join
    end
  end
end
