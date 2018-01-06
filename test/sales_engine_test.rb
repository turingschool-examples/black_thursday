require_relative 'test_helper'
require_relative "../lib/sales_engine"



class SalesEngineTest < Minitest::Test

  attr_reader :se

  def setup
    @se = SalesEngine.from_csv({:invoices => "./data/invoices.csv"})
  end

  def test_it_exists
    assert_instance_of SalesEngine, se
  end

  def test_it_initializes_new_items
    skip
    assert_instance_of ItemRepository, se.items
  end

  def test_it_initializes_new_merchants
    skip
    assert_instance_of MerchantRepository, se.merchants
  end

end
