require './test/test_helper'
require './lib/item_repository'

class ItemRepositoryTest < Minitest::Test

  def test_it_exists
    ir = ItemRepository.new

    assert_instance_of ItemRepository, ir
  end

  def test_it_initializes_with_an_empty_array
    ir = ItemRepository.new

    assert_equal [], ir.array
  end

end