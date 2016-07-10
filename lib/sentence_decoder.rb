require_relative "word_decoder"
module ParaMorse
  class SentenceDecoder
    def initialize
      @word_decoder = ParaMorse::WordDecoder.new
    end

    def decode(morse_code)
      code_words = morse_code.split("0000000")
      words = code_words.map do |code_word|
        @word_decoder.decode(code_word)
      end
      words.join(" ")
    end
  end
end
