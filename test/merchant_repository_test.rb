require './test/test_helper'
require './lib/sales_engine'

class MerchantRepositoryTest < Minitest::Test

  def test_it_creates_an_array
    se = SalesEngine.from_csv({ items: "./data/item_sample.csv", merchants: "./data/merchants_sample.csv" })
    mr = se.merchants
    assert_equal true, mr.all.is_a?(Array)
  end

  def test_it_populates_the_correct_number_of_merchants
    se = SalesEngine.from_csv({ items: "./data/item_sample.csv", merchants: "./data/merchants_sample.csv" })
    mr = se.merchants
    assert_equal 100, mr.all.length
  end



end
