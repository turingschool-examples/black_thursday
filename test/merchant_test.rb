require_relative 'test_helper'
require_relative '../lib/merchant'
require_relative '../lib/sales_engine'

class MerchantTest < Minitest::Test

  def setup
    data = {:id => 5, :name => "Turing School"}
    @merchant = Merchant.new(data)
  end

  def test_it_exists
    assert_instance_of Merchant, @merchant
  end

  def test_it_returns_an_id
    assert_equal 5, @merchant.id
  end

  def test_it_returns_a_different_id
    merchant = Merchant.new({:id => 23, :name => "Turing School"})

    assert_equal 23, merchant.id
  end

  def test_it_returns_a_name
    assert_equal "Turing School", @merchant.name
  end

  def test_it_returns_a_different_name
    merchant = Merchant.new({:id => 5, :name => "Yale Business School"})

    assert_equal "Yale Business School", merchant.name
  end

  def test_if_it_returns_all_items_for_a_merchant
    data = {
          :items     => "./test/fixtures/items_sample.csv",
          :merchants => "./test/fixtures/merchants_sample.csv",
            }
    sales_engine = SalesEngine.new(data)
    id = 12334185
    merchant = sales_engine.merchants.find_by_id(id)

    assert merchant.items.all? do |item|
      item.merchant_id == id
    end
    assert merchant.items.class == Array
    assert merchant.items.first.class == Item
    assert_equal 3, merchant.items.length
  end

end
