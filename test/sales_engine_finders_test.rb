require './test/test_helper'

class SalesEngineFindersTest < Minitest::Test
  
  attr_reader :se

  def setup
    @se = SalesEngine.from_csv({:merchants => './test/fixtures/merchants_100.csv',
                               :items => './data/items.csv',
                               :invoices => './test/fixtures/invoices_100.csv',
                               :invoice_items => './test/fixtures/invoice_items_100.csv',
                               :transactions => './test/fixtures/transaction_100.csv',
                               :customers => './test/fixtures/customer_100.csv'})
  end

  def test_find_invoice_items_by_invoice_id
    assert_instance_of Array, se.find_invoice_items_by_invoice_id(1)
    assert_instance_of InvoiceItem, se.find_invoice_items_by_invoice_id(1).first
    assert_equal 8, se.find_invoice_items_by_invoice_id(1).length
  end

  def test_find_items_by_invoice_id
    assert_instance_of Array, se.find_items_by_invoice_id(1)
    assert_instance_of Item, se.find_items_by_invoice_id(1).first
  end

end