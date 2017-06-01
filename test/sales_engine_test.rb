require "minitest/autorun"
require "minitest/pride"
require_relative "../lib/sales_engine"
require "pry"

class SalesEngineTest < Minitest::Test
  def test_it_exists
    item_dummy = CSV.open './data/small_item_set.csv', headers: true, header_converters: :symbol
    merch_dummy = CSV.open './data/merchant_sample.csv', headers: true, header_converters: :symbol
    se = SalesEngine.new(item_dummy, merch_dummy)

    assert_instance_of SalesEngine, se
  end

  def test_from_csv_returns_instance_of_sales_engine
    small_csv_paths = {
                        :items     => "./data/small_item_set.csv",
                        :merchants => "./data/merchant_sample.csv",
                      }
    se = SalesEngine.from_csv(small_csv_paths)

    assert_instance_of SalesEngine, se
  end
end
