require_relative 'dictionary'
module ParaMorse
  class LetterEncoder
    include MorseCodeDictionary
    attr_reader :letter_code_reference
    def initialize
      @letter_code_reference = dictionary
    end
    def encode(letter)
      @letter_code_reference[letter.downcase]
    end
  end
end
