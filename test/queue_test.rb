require 'SimpleCov'
SimpleCov.start
require 'minitest/autorun'
require 'minitest/pride'

require_relative '../lib/queue.rb'

class QueueTest < Minitest::Test
  def test_it_pushes_items_into_queue
    q = ParaMorse::Queue.new
    assert q.push('1')
  end

  def test_first_item_visibile_with_peek
    q = ParaMorse::Queue.new
    q.push('1')
    assert_equal "1", q.peek
    q.push('0')
    assert_equal "1", q.peek
    assert_equal ['1','0'], q.peek(2)
  end

  def test_last_item_visible_with_tail
    q = ParaMorse::Queue.new
    q.push('1')
    assert_equal "1", q.tail
    q.push('0')
    assert_equal '0', q.tail
    assert_equal ['0','1'], q.tail(2)
  end

  def test_it_can_pop_an_item_off
    q = ParaMorse::Queue.new
    q.push('1')
    assert_equal '1', q.pop
  end

  def test_it_can_pop_multiple_items
    q = ParaMorse::Queue.new
    q.push('1')
    q.push('0')
    assert_equal ['1','0'], q.pop(2)
  end

  def test_it_counts_items_in_the_queue
    q = ParaMorse::Queue.new
    q.push('1')
    assert_equal 1, q.count
    q.push('1')
    assert_equal 2, q.count
  end

  def test_it_can_be_cleared
    q = ParaMorse::Queue.new
    q.push('1')
    q.push('0')
    first_count = q.count
    q.clear

    refute_equal first_count, q.count
    assert_equal 0, q.count
  end
end
