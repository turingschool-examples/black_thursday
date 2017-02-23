require './test/test_helper'
require './lib/merchant'
require_relative '../lib/sales_engine'
require_relative '../lib/merchant_repository'

class MerchantTest < Minitest::Test
  def setup
    @se = SalesEngine.from_csv({
  :items     => "./data/items.csv",
  :merchants => "./data/merchants.csv"})

    @m = Merchant.new({:id => "5", :name => "Turing School"})
  end

  def test_assert_it_exists
    assert_instance_of Merchant, @m
  end

  def test_it_has_id
    assert_equal 5, @m.id
  end

  def test_it_has_name
    assert_equal "Turing School", @m.name
  end


end
