require './test/test_helper'
require './lib/sales_engine'
require './lib/file_loader'

class SalesEngineTest < Minitest::Test
  include FileLoader

  def setup
    @se = SalesEngine.from_csv({
      :items     => './data/items.csv',
      :merchants => './data/merchants.csv',
      :invoices => './data/invoices.csv',
      :invoice_items => './data/invoice_items.csv',
      :transactions => './data/transactions.csv',
      :customers => './data/customers.csv'
      })
  end

  def test_it_exists
    assert_instance_of SalesEngine, @se
  end

  def test_it_can_create_an_analyst
    se = SalesEngine.from_csv(
      items: './data/items.csv',
      merchants: './data/merchants.csv',
      invoices: './data/invoices.csv',
      invoice_items: './data/invoice_items.csv',
      transactions: './data/transactions.csv',
      customers: './data/customers.csv'
    )
    assert_instance_of SalesAnalyst, se.analyst
  end

  def test_it_can_find_a_merchant_by_name
    mr = @se.merchants
    merchant = mr.find_by_name('CJsDecor')

    assert_instance_of Merchant, merchant
    assert_equal 'CJsDecor', merchant.name
  end

  def test_it_can_find_an_item_by_name
    ir = @se.items
    item = ir.find_by_name('510+ RealPush Icon Set')

    assert_instance_of Item, item
    assert_equal '510+ RealPush Icon Set', item.name
  end

  def test_it_can_find_an_invoice_by_id
    inv_repo = @se.invoices
    invoice = inv_repo.find_by_id(1)

    assert_equal 1, invoice.id
  end

  def test_it_can_find_an_invoice_item_by_id
    inv_item_repo = @se.invoice_items
    invoice_item = inv_item_repo.find_by_id(1)

    assert_equal 1, invoice_item.id
  end

  def test_it_can_find_a_transaction_by_id
    tr = @se.transactions
    transaction = tr.find_by_id(1)

    assert_equal 1, transaction.id
  end

  def test_it_can_find_a_customer_by_id
    cr = @se.customers
    customer = cr.find_by_id(1)

    assert_equal 1, customer.id
  end
end
