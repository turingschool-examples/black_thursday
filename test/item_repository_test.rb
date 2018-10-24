require './test/test_helper'

class ItemRepositoryTest < Minitest::Test

  def test_it_exists
    i = ItemRepository.new('./test/item_sample.csv')
    assert_instance_of ItemRepository, i
  end

  def test_it_can_create_items
    skip
    i = ItemRepository.new('./test/item_sample.csv')
    assert_instance_of Array, i.create_item("./test/item_sample.csv")
  end

  def test_merchant_repo_has_merchants
    skip
    i = ItemRepository.new('./test/item_sample.csv')
    assert_equal 1, i.all
  end
end
