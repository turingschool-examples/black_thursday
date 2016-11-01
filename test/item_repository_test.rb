require './test/test_helper'
require './lib/item_repository'


class ItemRepositoryTest < Minitest::Test
  attr_reader :item_repository
  def setup
    @item_repository = ItemRepository.new
  end

  def test_it_exists
    assert item_repository
  end

end
