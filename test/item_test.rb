require_relative 'test_helper'
require_relative '../lib/item'
require_relative '../lib/sales_engine'

class ItemTest < Minitest::Test

  attr_reader :se, :item, :merch_repo

  #TODO Edge case testing!!

  def setup
    @se = SalesEngine.from_csv({
      :items     => "./data/small_items.csv",
      :merchants => "./data/small_merchants.csv",})
    @se.merchants
    @se.items
    @item_repo = @se.item_repo
    @item = @item_repo.items[18]
  end

  def test_we_can_retrieve_correct_secondary_item
    assert_equal true, item.merchant.name.include?("Urcase17")
  end


end
