gem 'minitest', '~> 5.2'
require 'minitest/autorun'
require 'minitest/pride'
require "./lib/merchant_repository"
require "./lib/sales_engine"


class MerchantRepositoryTest < MiniTest::Test
  def setup
    @se = SalesEngine.from_csv({
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv",})
  end

  def test_csv_instance_variable_is_csv
    assert_equal true, @se.merchants.csv?
  end

  def test_it_needs_opener
    assert_equal 0, @se.merchants.csv_opener
  end
end
