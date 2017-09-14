require_relative 'test_helper'
require_relative '../lib/sales_engine'

class SalesEngineTest < Minitest::Test
  def test_it_exists
    sales = SalesEngine.new([], [])


    assert_instance_of SalesEngine, sales
  end

  def test_from_csv_item
    sales = SalesEngine
    files = ({:items => "./test/fixtures/item_fixture.csv", :merchants => "./test/fixtures/merchant_fixture.csv"})
    actual = sales.from_csv(files).items

    assert_instance_of ItemRepository, actual
  end

  def test_from_csv_merchants
    sales = SalesEngine
    files = ({:items => "./test/fixtures/item_fixture.csv", :merchants => "./test/fixtures/merchant_fixture.csv"})
    actual = sales.from_csv(files).merchants

    assert_instance_of MerchantRepository, actual
  end

end
