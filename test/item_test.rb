require 'minitest/autorun'
require './lib/sales_engine'
require 'pry'
require 'csv'

class ItemTest < Minitest:: Test
  def test_it_knows_it_came_from
    skip
    item_repo = ItemRepository.new("")
    item_repo.create_item(:name => "This Thing")
    item = item_repo.items.first

    assert_equal item_repo, item.repository
  end

  def test_it_can_find_the_associated_merchant
    skip

    se.merchant_repository.create_merchant({:name =>"the merch", :id => 24})
    merchant = se.merchant_repository.merchants.first
    se.item_repository.create_item({:name => "merchthang", :merchant_id => 24})
    item = se.item_repository.items.first

    assert_equal merchant,  item.merchant
  end
end
