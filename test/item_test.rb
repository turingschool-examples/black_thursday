require_relative 'test_helper'
# require 'minitest/autorun'
# require 'minitest/pride'
# require 'pry'
require './lib/item'
require './lib/item_repository'
require './lib/sales_engine'
require './lib/merchant'


class ItemTest < MiniTest::Test

  def setup
    @item_repository = ItemRepository.new(nil)
    @sales_engine = SalesEngine.new
    @merchant = Merchant.new
  end

  def test_it_knows_where_it_came_from
    @item_repository.create_item(:name => "The Thing")
    item = @item_repository.items.first
    assert_equal @item_repository, item.parent
  end

  def test_it_can_find_the_merchant
    @sales_engine.merchant_repository.create_merchant({:name => "Mercher", :id => 24})
    merchant = @sales_engine.merchant_repository
    @sales_engine.item_repository.create_item(:name => "Thingy", :merchant_id => 24)
    assert_equal merchant, item.merchant
  end

end
