require_relative 'test_helper'
require_relative '../lib/sales_engine'
require_relative '../lib/merchant'
class MerchantTest < Minitest::Test
  def setup
    @engine = SalesEngine.from_csv({
      items: './data/items.csv',
      merchants: './data/merchants.csv',
      customers: './data/customers.csv',
      invoices: './data/invoices.csv',
      invoice_items: './data/invoice_items.csv',
      transactions: './data/transactions.csv'
    })
  end

  def test_it_exists
    assert_instance_of Merchant, @engine.merchants.merchants.first
  end

  def test_id_returns_the_merchant_id
    merchant = @engine.merchants.all.first
    assert_equal 12334105, merchant.id
  end

  def test_name_returns_the_merchant_name
    merchant1 = @engine.merchants.all.first
    merchant2 = @engine.merchants.all.last
    assert_equal 'Shopin1901', merchant1.name
    assert_equal 'CJsDecor', merchant2.name
  end

end
