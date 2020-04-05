require_relative 'test_helper'
require 'pry'

class MerchantTest < Minitest::Test

  def setup
    sales_engine = SalesEngine.from_csv({
      :items => './test/fixtures/items_fixture.csv',
      :merchants => './test/fixtures/merchants.csv',
      :invoices => './test/fixtures/invoices.csv',
      :invoice_items => './test/fixtures/invoice_items.csv',
      :transactions => './test/fixtures/transactions.csv',
      :customers => './test/fixtures/customers.csv'})
    merchants  = sales_engine.merchants
    @merchants = merchants.merchants
  end


  def test_class_merchant_exists
   merchant = @merchants[0]

   assert_instance_of Merchant, merchant
  end

  def test_merchant_can_search_for_id

  end


end
