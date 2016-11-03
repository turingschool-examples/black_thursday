require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/sales_engine'

class InvoiceMerchantIntegratedTest < Minitest::Test

  attr_reader :sales_engine

  def setup
    @sales_engine = SalesEngine.from_csv({
      :invoices => "./data_fixtures/invoices_fixture.csv",
      :merchants => "./data_fixtures/merchants_fixture.csv"
    })
  end

  # def test_merchant_knows_its_one_item
  #   merchant = sales_engine.merchants.find_by_id(12334141)
  #   items = merchant.items
  #   assert_equal 1, items.length
  #   assert items.one? {|item| item.id == 263395237}
  # end
  
  def test_merchant_knows_its_invoices
  	 merchant_id = 12334195
  	 merchant = sales_engine.merchants.find_by_id(merchant_id)
  	 invoices = merchant.invoices
  	 assert_equal 13, invoices.length
  	 assert invoices.all? {|invoice| invoice.merchant_id == merchant_id}
  end

  def test_merchant_returns_empty_array_when_merchant_has_no_invoices
  	 merchant_id = 12334183
  	 merchant = sales_engine.merchants.find_by_id(merchant_id)
  	 invoices = merchant.invoices
  	 assert_equal [], invoices
  end
  	 


end