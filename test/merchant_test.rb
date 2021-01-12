require 'minitest/autorun'
require 'minitest/pride'
require './lib/sales_engine'
require './lib/item_repo'
require './lib/item'
require './lib/merchant_repo'
require './lib/merchant'

class MerchantTest < Minitest::Test
  def test_it_exists
    sales_engine = SalesEngine.from_csv({
    :items     => "./fixtures/items_sample.csv",
    :merchants => "./fixtures/merchant_sample.csv",
    })

    merchant = Merchant.new({:id => 5, :name =>"Turing School"}, sales_engine)

    assert_instance_of Merchant, merchant
  end

  def test_it_has_attributes
    sales_engine = SalesEngine.from_csv({
    :items     => "./fixtures/items_sample.csv",
    :merchants => "./fixtures/merchant_sample.csv",
    })
    merchant = Merchant.new({:id => 5, :name =>"Turing School"}, sales_engine)

    assert_equal 5, merchant.id
    assert_equal "Turing School", merchant.name
  end
end
