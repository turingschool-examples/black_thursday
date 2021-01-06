require 'simplecov'
SimpleCov.start

require 'minitest/autorun'
require 'minitest/pride'
require './lib/sales_engine'

class SalesEngineTest < Minitest::Test
  def setup
    @file_items = CSV.readlines("./data/items.csv", headers: true, header_converters: :symbol)
    @file_merchants = CSV.readlines("./data/merchants.csv", headers: true, header_converters: :symbol)
    @se = SalesEngine.from_csv({
                              :items     => "./data/items.csv",
                              :merchants => "./data/merchants.csv",
                              })
  end

  def test_it_exists
    assert_instance_of SalesEngine, @se
  end

  def test_it_can_from_csv
    sales_engine = SalesEngine.from_csv({
                              :items     => "./data/items.csv",
                              :merchants => "./data/merchants.csv",
                              })
    assert_instance_of SalesEngine, sales_engine
  end

  def test_it_has_readable_attributes
    assert_equal ItemRepository, @se.items.class
    assert_equal MerchantRepository, @se.merchants.class
  end

  def test_it_can_create_arrays_of_items_and_merchants
    assert_instance_of Array, @se.item_repository(@file_items).items
    assert_instance_of Array, @se.merchant_repository(@file_merchants).merchants
  end
end
