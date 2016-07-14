require "./lib/stream_decoder"
require "./lib/file_encoder"
require "./lib/split_stream"
require "./lib/letter_decoder"

module ParaMorse
  class ParallelEncoder

    

    # read in files as split streams, which gives me encoded strngs
    # create streams for each split stream, which gives me q functs
    # iterate over encoded strngs and recieve char
    # check each stream for spaces or end of characters
    # flag stream true if:

      # contains_letter? it contains a char followed by a "000"
        # strip off trailing 000
        # decode letter
        # add letter to decoded string
      # contains_n_spaces? it contains n spaces followed by a 1
        # create a spaces class
          # count 0's
          # count divided by 7 = number of spaces
          # stream to flags true until all spaces have been
          # popped off a space when all other streams are true
          # add space to decoded string

    # write decoded string to file


  end
end
