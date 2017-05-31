require_relative 'test_helper'

require './lib/sales_engine'

class SalesEngineTest < Minitest::Test

  def test_sales_engine_exists
    skip
    se = SalesEngine.from_csv(data_files)

    assert_instance_of SalesEngine, se
  end

  def test_that_sales_engine_is_right_class
    skip
    se = SalesEngine.from_csv(data_files)
    actual = se.class
    expected = SalesEngine
    assert_equal expected, actual
  end

  def test_from_csv_takes_hashes
    skip
    se = SalesEngine.from_csv(data_files)
    actual = data_files.class
    expected = Hash
  end

  def test_merchants_creates_instance_of_merchant_repository
    skip
    se = SalesEngine.from_csv(data_files)
    actual = se.merchants

    assert_instance_of MerchantRepository, actual
  end
end
