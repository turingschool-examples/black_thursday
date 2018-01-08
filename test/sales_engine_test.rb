require_relative "test_helper"
require_relative "../lib/sales_engine"

class SalesEngineTest < Minitest::Test

  def test_it_exists
    se = SalesEngine.from_csv({
      :items         => "./test/fixtures/items_truncated.csv",
      :merchants     => "./test/fixtures/merchants_truncated.csv",
      :invoices      => "./test/fixtures/invoices_truncated.csv",
      :invoice_items => "./test/fixtures/invoice_items_truncated.csv",
      :transactions  => "./test/fixtures/transactions_truncated.csv",
      :customers     => "./test/fixtures/customers_truncated.csv"
    })

    assert_instance_of SalesEngine, se
  end

  def test_se_has_instances_child_classes
    se = SalesEngine.from_csv({
      :items         => "./test/fixtures/items_truncated.csv",
      :merchants     => "./test/fixtures/merchants_truncated.csv",
      :invoices      => "./test/fixtures/invoices_truncated.csv",
      :invoice_items => "./test/fixtures/invoice_items_truncated.csv",
      :transactions  => "./test/fixtures/transactions_truncated.csv",
      :customers     => "./test/fixtures/customers_truncated.csv"
    })

    assert_instance_of MerchantRepo, se.merchants
    assert_instance_of ItemRepo, se.items
  end

  def test_item_merchant_can_be_found
    se = SalesEngine.from_csv({
      :items         => "./test/fixtures/items_truncated.csv",
      :merchants     => "./test/fixtures/merchants_truncated.csv",
      :invoices      => "./test/fixtures/invoices_truncated.csv",
      :invoice_items => "./test/fixtures/invoice_items_truncated.csv",
      :transactions  => "./test/fixtures/transactions_truncated.csv",
      :customers     => "./test/fixtures/customers_truncated.csv"
    })

    assert_equal "jejum", se.find_merchant(12334141).name
    assert_equal 15, se.merchants.merchants.count
    assert_equal 65, se.items.items.count
    assert_instance_of Merchant, se.merchants.merchants.first
    assert_instance_of Item, se.items.items.first
  end

  def test_find_items_by_merchant_id_finds_items_by_merchant_id
    se = SalesEngine.from_csv({
      :items         => "./test/fixtures/items_truncated.csv",
      :merchants     => "./test/fixtures/merchants_truncated.csv",
      :invoices      => "./test/fixtures/invoices_truncated.csv",
      :invoice_items => "./test/fixtures/invoice_items_truncated.csv",
      :transactions  => "./test/fixtures/transactions_truncated.csv",
      :customers     => "./test/fixtures/customers_truncated.csv"
    })

    assert_instance_of Array, se.find_items_by_merchant_id(12334141)
    se.find_items_by_merchant_id(12334141).each do |item|
      assert_instance_of Item, item
      assert_equal 12334141, item.merchant_id
    end
  end

  def test_find_invoices_by_merchant_id_finds_invoices_by_merchant_id
    se = SalesEngine.from_csv({
      :items         => "./test/fixtures/items_truncated.csv",
      :merchants     => "./test/fixtures/merchants_truncated.csv",
      :invoices      => "./test/fixtures/invoices_truncated.csv",
      :invoice_items => "./test/fixtures/invoice_items_truncated.csv",
      :transactions  => "./test/fixtures/transactions_truncated.csv",
      :customers     => "./test/fixtures/customers_truncated.csv"
    })

    assert_instance_of Array, se.find_invoices_by_merchant_id(12334141)
    se.find_invoices_by_merchant_id(12334141).each do |invoice|
      assert_instance_of Invoice, invoice
      assert_equal 12334141, invoice.merchant_id
    end
  end

  def test_find_invoice_items_by_invoice_id_finds_invoice_items_by_invoice_id
    se = SalesEngine.from_csv({
      :items         => "./test/fixtures/items_truncated.csv",
      :merchants     => "./test/fixtures/merchants_truncated.csv",
      :invoices      => "./test/fixtures/invoices_truncated.csv",
      :invoice_items => "./test/fixtures/invoice_items_truncated.csv",
      :transactions  => "./test/fixtures/transactions_truncated.csv",
      :customers     => "./test/fixtures/customers_truncated.csv"
    })

    assert_instance_of Array, se.find_invoice_items_by_invoice_id(1)
    se.find_invoice_items_by_invoice_id(1).each do |invoice_item|
      assert_instance_of InvoiceItem, invoice_item
      assert_equal 1, invoice_item.invoice_id
    end
  end

  def test_find_item_by_item_id_finds_item_by_item_id
    se = SalesEngine.from_csv({
      :items         => "./test/fixtures/items_truncated.csv",
      :merchants     => "./test/fixtures/merchants_truncated.csv",
      :invoices      => "./test/fixtures/invoices_truncated.csv",
      :invoice_items => "./test/fixtures/invoice_items_truncated.csv",
      :transactions  => "./test/fixtures/transactions_truncated.csv",
      :customers     => "./test/fixtures/customers_truncated.csv"
    })

    assert_instance_of Item, se.find_item_by_item_id(263395237)
    assert_equal 263395237, se.find_item_by_item_id(263395237).id
  end

  def test_find_transactions_by_invoice_id_finds_transactions_by_invoice_id
    se = SalesEngine.from_csv({
      :items         => "./test/fixtures/items_truncated.csv",
      :merchants     => "./test/fixtures/merchants_truncated.csv",
      :invoices      => "./test/fixtures/invoices_truncated.csv",
      :invoice_items => "./test/fixtures/invoice_items_truncated.csv",
      :transactions  => "./test/fixtures/transactions_truncated.csv",
      :customers     => "./test/fixtures/customers_truncated.csv"
    })

    assert_instance_of Array, se.find_transactions_by_invoice_id(2179)
    se.find_transactions_by_invoice_id(2179).each do |transaction|
      assert_instance_of Transaction, transaction
      assert_equal 2179, transaction.invoice_id
    end
  end

  def test_find_customer_by_id_finds_customer_by_id
    se = SalesEngine.from_csv({
      :items         => "./test/fixtures/items_truncated.csv",
      :merchants     => "./test/fixtures/merchants_truncated.csv",
      :invoices      => "./test/fixtures/invoices_truncated.csv",
      :invoice_items => "./test/fixtures/invoice_items_truncated.csv",
      :transactions  => "./test/fixtures/transactions_truncated.csv",
      :customers     => "./test/fixtures/customers_truncated.csv"
    })

      assert_instance_of Customer, se.find_customer_by_id(1)
      assert_equal 1, se.find_customer_by_id(1).id
  end

  def test_find_by_invoice_id_finds_by_invoice_id
    se = SalesEngine.from_csv({
      :items         => "./test/fixtures/items_truncated.csv",
      :merchants     => "./test/fixtures/merchants_truncated.csv",
      :invoices      => "./test/fixtures/invoices_truncated.csv",
      :invoice_items => "./test/fixtures/invoice_items_truncated.csv",
      :transactions  => "./test/fixtures/transactions_truncated.csv",
      :customers     => "./test/fixtures/customers_truncated.csv"
    })

    assert_instance_of Invoice, se.find_by_invoice_id(2179)
    assert_equal 2179, se.find_by_invoice_id(2179).id
  end

  def test_find_customer_by_customer_id_finds_customer_by_customer_id
    se = SalesEngine.from_csv({
      :items         => "./test/fixtures/items_truncated.csv",
      :merchants     => "./test/fixtures/merchants_truncated.csv",
      :invoices      => "./test/fixtures/invoices_truncated.csv",
      :invoice_items => "./test/fixtures/invoice_items_truncated.csv",
      :transactions  => "./test/fixtures/transactions_truncated.csv",
      :customers     => "./test/fixtures/customers_truncated.csv"
    })

    assert_instance_of Customer, se.find_customer_by_customer_id(1)
    assert_equal 1, se.find_customer_by_customer_id(1).id
  end

  def test_find_invoices_by_customer_id_finds_invoices_by_customer_id
    se = SalesEngine.from_csv({
      :items         => "./test/fixtures/items_truncated.csv",
      :merchants     => "./test/fixtures/merchants_truncated.csv",
      :invoices      => "./test/fixtures/invoices_truncated.csv",
      :invoice_items => "./test/fixtures/invoice_items_truncated.csv",
      :transactions  => "./test/fixtures/transactions_truncated.csv",
      :customers     => "./test/fixtures/customers_truncated.csv"
    })

    assert_instance_of Array, se.find_invoices_by_customer_id(1)
    se.find_invoices_by_customer_id(1).each do |invoice|
      assert_instance_of Invoice, invoice
      assert_equal 1, invoice.customer_id
    end
  end

  def test_find_all_merchants_by_id_finds_all_merchants_by_id
    se = SalesEngine.from_csv({
      :items         => "./test/fixtures/items_truncated.csv",
      :merchants     => "./test/fixtures/merchants_truncated.csv",
      :invoices      => "./test/fixtures/invoices_truncated.csv",
      :invoice_items => "./test/fixtures/invoice_items_truncated.csv",
      :transactions  => "./test/fixtures/transactions_truncated.csv",
      :customers     => "./test/fixtures/customers_truncated.csv"
    })

    assert_instance_of Array, se.find_all_merchants_by_id(12334105)
    se.find_all_merchants_by_id(12334105).each do |merchant|
      assert_instance_of Merchant, merchant
      assert_equal 12334105, merchant.id
    end
  end
end
