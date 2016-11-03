require_relative 'test_helper'
require './lib/merchant'
require './lib/sales_engine'

class MerchantTest < Minitest::Test


  def test_it_exists
    se = SalesEngine.from_csv({
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv"})

  end

  def test_it_has_id_and_name
    se = SalesEngine.from_csv({
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv"})
    merch = se.merchants.all[0]
    assert_equal 12334105, merch.id
    assert_equal "Shopin1901", merch.name
  end
  

end