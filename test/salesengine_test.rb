require './test/test_helper'
require './lib/salesengine'

class SalesEngineTest < Minitest::Test
  # def test_it_exists
  #   assert SalesEngine.new
  # end
  #
  # def test_it_has_a_csv_method
  #   assert_respond_to(SalesEngine, :from_csv)
  # end
  #
  def test_it_takes_in_sample_merchant_csv
    se = SalesEngine.from_csv({:merchants => "./data/merchants_sample.csv"})
    # require "pry"; binding.pry
    assert_instance_of MerchantRepository, se.merchants
  end


  # def test_it_returns_an_item
  #   se = SalesEngine.from_csv({
  #   :items     => "./data/items.csv",
  #   :merchants => "./data/merchants.csv"
  # })
  #
  # ir   = se.items
  # item = ir.find_by_name("Item Repellat Dolorum")
  # end




  # def test_it_
  # end
end
#return value
#method to parse csv (file name = hash: key, merchants)
#as you iterate through, a new merchant can be created on every row, and be
#stored in a merchant repository array
#merchants and repo are created, then on line 16, you have a method or
#instance variable that
