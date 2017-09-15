require_relative 'test_helper'
require_relative '../lib/sales_engine'

class SalesEngineTest < Minitest::Test
  attr_reader :files, :se
  def set_up
    files = ({:items => "./test/fixtures/item_fixture.csv", :merchants => "./test/fixtures/merchant_fixture.csv"})
    @se = SalesEngine.from_csv(files)
  end

  def test_it_exists
    set_up

    assert_instance_of SalesEngine, se
  end

  def test_from_csv_item
    set_up

    assert_instance_of ItemRepository, se.items
  end

  def test_from_csv_merchants
    set_up

    assert_instance_of MerchantRepository, se.merchants
  end
end
