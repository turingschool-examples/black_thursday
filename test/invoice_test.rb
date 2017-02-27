require './test/test_helper'
require './lib/invoice'
require './lib/sales_engine'

class InvoiceTest < Minitest::Test
  def setup
    @se = SalesEngine.from_csv({
      :invoices => "./data/invoices.csv",
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv",
      })
    @i = @se.invoices
  end


  def test_invoice_exists
    assert_equal 1, @i.all.first.id
    assert_equal 1, @i.all.first.customer_id
    assert_equal 12335938, @i.all.first.merchant_id
    assert_equal :pending, @i.all.first.status
  end

  def test_invoice_has_attached_merchant
    invoice = @i.find_by_id(20)

    assert_instance_of Merchant, invoice.merchant

  end

end
