require './test/test_helper'
require './lib/parallel_streams.rb'

class ParallelStreamsTest < Minitest::Test

  def test_it_contains_n_streams
    n1 = 2
    n2 = 8
    n3 = 0
    parallel_streams1 = ParaMorse::ParallelStreams.new(n1)
    parallel_streams2 = ParaMorse::ParallelStreams.new(n2)
    parallel_streams3 = ParaMorse::ParallelStreams.new(n3)
    expected1 = n1
    expected2 = n2
    expected3 = n3

    actual1 = parallel_streams1.count
    actual2 = parallel_streams2.count
    actual3 = parallel_streams3.count

    assert_equal expected1, actual1
    assert_equal expected2, actual2
    assert_equal expected3, actual3
  end

end
