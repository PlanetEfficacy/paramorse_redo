require 'SimpleCov'
SimpleCov.start
require 'minitest/autorun'
require 'minitest/pride'

require_relative '../lib/queue.rb'

class QueueTest < Minitest::Test
  def setup
    q = Queue.new
  end
  def test_it_pushes_items_into_queue
    assert q.push('1')
  end

  def test_it_can_pop_items_off
    q.push('1')
    assert_equal '1', q.pop
  end
  def test_it_counts_pushed_items
    q.push('1')
    assert_equal 1, q.count
    q.push('1')
    assert_equal 2, q.count
  end
end
