require_relative 'test_helper.rb'
require_relative '../lib/merchant.rb'
require_relative '../lib/sales_engine.rb'

class MerchantTest < Minitest::Test
  def setup
    sales_engine = SalesEngine.new({
      items: './test/fixtures/items.csv',
      merchants: './test/fixtures/merchants_fix.csv',
      invoices: './test/fixtures/invoices.csv'
      })
    @merchant = Merchant.new({:id => '5', :name => 'Turing School'}, sales_engine.merchants)
  end

  def test_merchant_initializes
    assert_instance_of Merchant, @merchant
  end

  def test_merchant_has_id_and_name
    assert_equal 5, @merchant.id
    assert_equal 'Turing School', @merchant.name
  end
end
