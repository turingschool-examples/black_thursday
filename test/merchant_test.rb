require './test/test_helper.rb'
# require 'minitest/autorun'
# require 'minitest/pride'
require './lib/merchant.rb'
require './lib/merchant_repository.rb'
require './lib/sales_engine.rb'
require 'pry'

class MerchantTest < Minitest::Test

  def setup
    se = SalesEngine.from_csv({
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv",
      })
    @merchant_1 = se.merchants.repository[0].merchant
  end

  def test_it_exists
    m = Merchant.new(@merchant_1)
    assert_instance_of Merchant, m
  end

  def test_merchant_has_attributes
    m = Merchant.new(@merchant_1)
    assert_equal 12334105, m.id
    assert_equal 'Shopin1901', m.name
    assert_equal '2010-12-10', m.created_at
    assert_equal '2011-12-04', m.updated_at
  end
end
