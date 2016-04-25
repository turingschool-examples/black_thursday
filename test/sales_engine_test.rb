require_relative 'test_helper'
require_relative '../lib/sales_engine'


class SalesEngineTest < Minitest::Test

  def setup
    @se = SalesEngine.from_csv({
      :items => "./data/items.csv",
      :merchants => "./data/merchants.csv",
      :invoices => "./data/invoices.csv",
      :invoice_items => "./data/invoice_items.csv",
      :transactions => "./data/transactions.csv",
      :customers => "./data/customers.csv"})
  end

  def test_it_created_instance_of_sales_engine_class
    assert_equal SalesEngine, @se.class
  end

  def test_it_can_create_a_new_merchant_repo_with_instances_of_merchant
    mr = @se.merchants
    assert mr
    assert_equal MerchantRepository, mr.class
    assert_equal Merchant, mr.merchant_array[0].class
  end

  def test_it_can_create_a_new_item_repo_with_instances_of_items
    ir = @se.items
    assert ir
    assert_equal ItemRepository, ir.class
  end

  def test_it_can_interact_with_merchants_class
    mr = @se.merchants
    merchant = mr.find_by_name("CJsDecor")
    assert_equal Merchant, merchant.class
  end

  def test_sales_engine_will_find_items_by_merchant_id
    items = @se.find_items_by_merch_id(12337411)
    assert items
    assert_equal Array, items.class
    assert_equal Item, items[0].class
  end

  def test_it_will_return_merchant_by_merchant_id
    merchant = @se.find_merchant_by_merch_id(12337411)
    assert merchant
    assert_equal Merchant, merchant.class
  end

  def test_it_can_interact_with_items_class
    ir = @se.items
    item = ir.find_by_name("510+ RealPush Icon Set")
    assert_equal Item, item.class
  end

  def test_it_can_return_item_if_items_is_called_on_merchants
    merchant = @se.merchants.find_by_id(12337411)
    item_instances = merchant.items
    assert_equal Item, item_instances[0].class
    item_name = "Flower Kissing Balls Pomander Flower Balls/Pew Flower Balls"
    assert_equal item_name, item_instances[0].name
  end

  def test_it_can_return_merchant_if_items_is_called_on_merchants
    ir = @se.items.find_all_by_merchant_id(12337411)
    item = ir[0]
    merchant_instance = item.merchant

    assert_equal Merchant, merchant_instance.class
  end

  def test_it_will_return_invoices_by_merchant_id
    merchant = @se.merchants.find_by_id(12337411)
    invoice_instances = merchant.invoices
    assert_equal Invoice, invoice_instances[0].class
  end

  def test_it_will_return_merchant_by_invoice_merchant_id
    ir = @se.items.find_all_by_merchant_id(12337411)
    invoice = ir[0]
    merchant_instance = invoice.merchant

    assert_equal Merchant, merchant_instance.class
  end

  def test_it_can_create_a_new_invoice_repo_with_instances_of_invoice
    invr = @se.invoices
    assert invr
    assert_equal InvoiceRepository, invr.class
    assert_equal Invoice, invr.invoice_repository[0].class
  end

  def test_it_can_create_a_new_invoice_repo_with_instances_of_invoice
    iir = @se.invoice_items
    assert iir
    assert_equal InvoiceItemRepository, iir.class
    assert_equal InvoiceItem, iir.invoice_item_repository[0].class
  end

  def test_it_can_create_a_new_invoice_repo_with_instances_of_invoice
    tr = @se.transactions
    assert tr
    assert_equal TransactionRepository, tr.class
    assert_equal Transaction, tr.transaction_repository[0].class
  end

  def test_it_can_create_a_new_invoice_repo_with_instances_of_invoice
    cr = @se.customers
    assert cr
    assert_equal CustomerRepository, cr.class
    assert_equal Customer, cr.customer_repository[0].class
  end

  def test_it_can_find_invoice_items_by_invoice_id
    invoice_items = @se.find_invoice_items_with_invoice_id(6)
    assert invoice_items
    assert_equal Array, invoice_items.class
    assert_equal InvoiceItem, invoice_items[0].class
  end

  def test_it_can_find_customers_by_id
    customer = @se.find_customer_by_id(6)
    assert customer
    assert_equal Customer, customer.class
    assert_equal "Heber", customer.first_name
  end

end
