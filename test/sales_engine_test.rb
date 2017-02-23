require 'minitest/autorun'
require 'minitest/pride'
require 'pry'
require_relative '../lib/sales_engine'

# SalesFactory
class SalesEngineTest < Minitest::Test

  def test_from_csv
    # setup your test
    file_hash = {
      items: './data/items.csv',
     merchants: './data/merchants.csv'
    }
    se = SalesEngine.from_csv(file_hash)
    # assert_equal Hash, se.class
    assert_equal ItemRepository, se.items.class
    assert_equal MerchantRepository, se.merchants.class
  end
end
