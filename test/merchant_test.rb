require 'bigdecimal'
require './lib/sales_engine'
require './lib/merchant'
require 'csv'
require 'minitest/autorun'
require 'minitest/emoji'

class MerchantTest < Minitest::Test

  def setup
    @se = SalesEngine.from_csv({
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv",
      })
    @merchant = @se.merchant.find_by_id(12334105)
    @merch = Merchant.new({:id => 5, :name => "Turing School"}, @se.merchant)

  end

  def test_it_exists
    assert_instance_of Merchant, @merch
  end

  def test_it_has_an_id
    assert_equal 5, @merch.id
  end

  def test_items_returns_array_of_items_objects
    assert_instance_of Array, @merchant.items
    assert_instance_of Item, @merchant.items[0]
    assert_equal 3, @merchant.items.count
  end



end
