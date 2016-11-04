require_relative 'test_helper'
require './lib/merchant'
require './lib/sales_engine'

class MerchantTest < Minitest::Test

  def setup
    @se = SalesEngine.from_csv({
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv"})
    @merch = @se.merchants.all[0]
  end

  def test_it_exists
    assert @merch
  end

  def test_it_is_a_merchant
    assert_equal Merchant, @merch.class
  end

  def test_it_has_name_and_id
    assert_equal 12334105, @merch.id
    assert_equal "Shopin1901", @merch.name
  end
  
  def test_it_can_find_its_items_in_an_array
    binding.pry
    assert_equal Array, @merch.items.class
  end
end