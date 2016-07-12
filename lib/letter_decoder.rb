require_relative 'dictionary'
module ParaMorse
  class LetterDecoder
    include MorseCodeDictionary
    def initialize
      @letter_code_reference = dictionary
    end
    def decode(input)
      @letter_code_reference.key(input)
    end
  end
end
