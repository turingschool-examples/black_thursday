require './test/test_helper'
require './lib/sales_engine'

class SalesEngineTest < Minitest::Test
  include TestSetup

  def setup
    @se = @@se
  end

  def test_sales_engine_exists
    assert_instance_of SalesEngine, @se
  end

  def test_se_merchant_method_reads_merchant_file
    assert_instance_of MerchantRepository, @se.merchants
  end

  def test_se_merchant_method_reads_items_file
    assert_instance_of ItemRepository, @se.items
  end

end
