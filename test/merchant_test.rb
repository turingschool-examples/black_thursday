require_relative 'test_helper'
require_relative '../lib/merchant'
require_relative '../lib/sales_engine'

class MerchantTest < Minitest::Test

  attr_reader :merch_repo, :se, :merchant

  def setup
    @se = SalesEngine.from_csv({
      :items     => "./data/small_items.csv",
      :merchants => "./data/small_merchants.csv",})
    @se.items
    @merch_repo = @se.merchants
    @merchant = @merch_repo.merchants[8]
  end

  def test_we_can_retrieve_all_items_sold_by_a_merch
    assert_equal 2, merchant.items.length
  end

  def test_we_can_retrieve_correct_item
    assert_equal true, merchant.items[0].name.include?("bulldog")
  end

  def test_we_can_retrieve_correct_secondary_item
    assert_equal true, merchant.items[1].name.include?("Jamaica")
  end



end
