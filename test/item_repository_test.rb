require "./test/test_helper"
require "./lib/sales_engine"
require "./lib/item_repository"
require './lib/item'

class ItemRepositoryTest < Minitest::Test

  attr_reader :item_repo

  def setup
    item_csv = "./test/test_data/items_short.csv"
    @item_repo = ItemRepository.new('fake_se', item_csv)
  end

  def test_it_exists
    assert_instance_of ItemRepository, item_repo
  end

  def test_items_short
    assert_instance_of Array, item_repo.all
  end

end
