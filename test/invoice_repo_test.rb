require_relative "test_helper"
require_relative "../lib/invoice_repo"
require_relative "../lib/sales_engine"

class InvoiceRepoTest < Minitest::Test

  def test_it_exist
    se = SalesEngine.from_csv({
      :items         => "./test/fixtures/items_truncated.csv",
      :merchants     => "./test/fixtures/merchants_truncated.csv",
      :invoices      => "./test/fixtures/invoices_truncated.csv",
      :invoice_items => "./test/fixtures/invoice_items_truncated.csv",
      :transactions  => "./test/fixtures/transactions_truncated.csv",
      :customers     => "./test/fixtures/customers_truncated.csv"
    })

    ir = InvoiceRepo.new(se, "./test/fixtures/invoices_truncated.csv")

    assert_instance_of InvoiceRepo, ir
  end

  def test_it_can_create_invoice_instances
    se = SalesEngine.from_csv({
      :items         => "./test/fixtures/items_truncated.csv",
      :merchants     => "./test/fixtures/merchants_truncated.csv",
      :invoices      => "./test/fixtures/invoices_truncated.csv",
      :invoice_items => "./test/fixtures/invoice_items_truncated.csv",
      :transactions  => "./test/fixtures/transactions_truncated.csv",
      :customers     => "./test/fixtures/customers_truncated.csv"
    })

    ir = InvoiceRepo.new(se, "./test/fixtures/invoices_truncated.csv")

    assert_instance_of Invoice, ir.invoices.first
  end

  def test_it_can_reach_the_invoice_instances_through_all
    se = SalesEngine.from_csv({
      :items         => "./test/fixtures/items_truncated.csv",
      :merchants     => "./test/fixtures/merchants_truncated.csv",
      :invoices      => "./test/fixtures/invoices_truncated.csv",
      :invoice_items => "./test/fixtures/invoice_items_truncated.csv",
      :transactions  => "./test/fixtures/transactions_truncated.csv",
      :customers     => "./test/fixtures/customers_truncated.csv"
    })

    ir = InvoiceRepo.new(se, "./test/fixtures/invoices_truncated.csv")

    assert_instance_of Invoice, ir.all.first
  end

  def test_it_can_find_invoices_by_id
    se = SalesEngine.from_csv({
      :items         => "./test/fixtures/items_truncated.csv",
      :merchants     => "./test/fixtures/merchants_truncated.csv",
      :invoices      => "./test/fixtures/invoices_truncated.csv",
      :invoice_items => "./test/fixtures/invoice_items_truncated.csv",
      :transactions  => "./test/fixtures/transactions_truncated.csv",
      :customers     => "./test/fixtures/customers_truncated.csv"
    })

    ir = InvoiceRepo.new(se, "./test/fixtures/invoices_truncated.csv")

    results = ir.find_by_id(74)

    assert_equal 12334105, results.merchant_id
  end

  def test_it_can_find_invoices_by_customer_id
    se = SalesEngine.from_csv({
      :items         => "./test/fixtures/items_truncated.csv",
      :merchants     => "./test/fixtures/merchants_truncated.csv",
      :invoices      => "./test/fixtures/invoices_truncated.csv",
      :invoice_items => "./test/fixtures/invoice_items_truncated.csv",
      :transactions  => "./test/fixtures/transactions_truncated.csv",
      :customers     => "./test/fixtures/customers_truncated.csv"
    })

    ir = InvoiceRepo.new(se, "./test/fixtures/invoices_truncated.csv")

    results = ir.find_all_by_customer_id(300)

    assert_equal 1, results.length
  end

  def test_find_by_customer_id_can_return_an_empty_array
    se = SalesEngine.from_csv({
      :items         => "./test/fixtures/items_truncated.csv",
      :merchants     => "./test/fixtures/merchants_truncated.csv",
      :invoices      => "./test/fixtures/invoices_truncated.csv",
      :invoice_items => "./test/fixtures/invoice_items_truncated.csv",
      :transactions  => "./test/fixtures/transactions_truncated.csv",
      :customers     => "./test/fixtures/customers_truncated.csv"
    })

    ir = InvoiceRepo.new(se, "./test/fixtures/invoices_truncated.csv")

    results = ir.find_all_by_customer_id(000000)

    assert_equal [], results
  end

  def test_it_can_find_all_by_merchant_id
    se = SalesEngine.from_csv({
      :items         => "./test/fixtures/items_truncated.csv",
      :merchants     => "./test/fixtures/merchants_truncated.csv",
      :invoices      => "./test/fixtures/invoices_truncated.csv",
      :invoice_items => "./test/fixtures/invoice_items_truncated.csv",
      :transactions  => "./test/fixtures/transactions_truncated.csv",
      :customers     => "./test/fixtures/customers_truncated.csv"
    })

    ir = InvoiceRepo.new(se, "./test/fixtures/invoices_truncated.csv")

    results = ir.find_all_by_merchant_id(12334105)

    assert_equal 10, results.count
    assert_equal 74, results.first.id
  end

  def test_find_by_merchant_id_can_return_an_empty_array
    se = SalesEngine.from_csv({
      :items         => "./test/fixtures/items_truncated.csv",
      :merchants     => "./test/fixtures/merchants_truncated.csv",
      :invoices      => "./test/fixtures/invoices_truncated.csv",
      :invoice_items => "./test/fixtures/invoice_items_truncated.csv",
      :transactions  => "./test/fixtures/transactions_truncated.csv",
      :customers     => "./test/fixtures/customers_truncated.csv"
    })

    ir = InvoiceRepo.new(se, "./test/fixtures/invoices_truncated.csv")

    results = ir.find_all_by_merchant_id(000000)

    assert_equal [], results
  end

  def test_find_by_invoices_by_status
    se = SalesEngine.from_csv({
      :items         => "./test/fixtures/items_truncated.csv",
      :merchants     => "./test/fixtures/merchants_truncated.csv",
      :invoices      => "./test/fixtures/invoices_truncated.csv",
      :invoice_items => "./test/fixtures/invoice_items_truncated.csv",
      :transactions  => "./test/fixtures/transactions_truncated.csv",
      :customers     => "./test/fixtures/customers_truncated.csv"
    })

    ir = InvoiceRepo.new(se, "./test/fixtures/invoices_truncated.csv")

    results = ir.find_all_by_status(:pending)

    assert_equal 49, results.length
  end

  def test_find_by_status_can_return_an_empty_array
    se = SalesEngine.from_csv({
      :items         => "./test/fixtures/items_truncated.csv",
      :merchants     => "./test/fixtures/merchants_truncated.csv",
      :invoices      => "./test/fixtures/invoices_truncated.csv",
      :invoice_items => "./test/fixtures/invoice_items_truncated.csv",
      :transactions  => "./test/fixtures/transactions_truncated.csv",
      :customers     => "./test/fixtures/customers_truncated.csv"
    })

    ir = InvoiceRepo.new(se, "./test/fixtures/invoices_truncated.csv")

    results = ir.find_all_by_status(:received)

    assert_equal [], results
  end

  def test_it_can_find_all_by_created_date
    se = SalesEngine.from_csv({
      :items         => "./test/fixtures/items_truncated.csv",
      :merchants     => "./test/fixtures/merchants_truncated.csv",
      :invoices      => "./test/fixtures/invoices_truncated.csv",
      :invoice_items => "./test/fixtures/invoice_items_truncated.csv",
      :transactions  => "./test/fixtures/transactions_truncated.csv",
      :customers     => "./test/fixtures/customers_truncated.csv"
    })

    ir = InvoiceRepo.new(se, "./test/fixtures/invoices_truncated.csv")

    results = ir.find_all_by_created_date(Time.parse("2005-01-03"))

    assert_equal 1, results.count
    assert_equal 74, results.first.id
    assert_equal 12334105, results.first.merchant_id
  end

  def test_it_can_find_merchant_by_id
    se = SalesEngine.from_csv({
      :items         => "./data/items.csv",
      :merchants     => "./data/merchants.csv",
      :invoices      => "./test/fixtures/invoices_truncated.csv",
      :invoice_items => "./data/invoice_items.csv",
      :transactions  => "./data/transactions.csv",
      :customers     => "./data/customers.csv"
    })

    ir = InvoiceRepo.new(se, "./test/fixtures/invoices_truncated.csv")

    results = ir.find_merchant_by_id(12335938)

    assert_equal 12335938, results.id
  end

  def test_it_can_find_invoice_items_by_invoice_id
     se = SalesEngine.from_csv({
      :items         => "./data/items.csv",
      :merchants     => "./data/merchants.csv",
      :invoices      => "./test/fixtures/invoices_truncated.csv",
      :invoice_items => "./data/invoice_items.csv",
      :transactions  => "./data/transactions.csv",
      :customers     => "./data/customers.csv"
    })

    ir = InvoiceRepo.new(se, "./test/fixtures/invoices_truncated.csv")

    results = ir.find_invoice_items_by_invoice_id(12)

    assert_instance_of Array, results
    assert_equal 6, results.count
    assert_instance_of Integer, results.first.id
    assert_equal 56, results.first.id
    assert_equal 12, results.first.invoice_id
  end

  def test_it_can_find_transactions_by_invoice_id
     se = SalesEngine.from_csv({
      :items         => "./data/items.csv",
      :merchants     => "./data/merchants.csv",
      :invoices      => "./test/fixtures/invoices_truncated.csv",
      :invoice_items => "./data/invoice_items.csv",
      :transactions  => "./data/transactions.csv",
      :customers     => "./data/customers.csv"
    })

    ir = InvoiceRepo.new(se, "./test/fixtures/invoices_truncated.csv")

    results = ir.find_transactions_by_invoice_id(12)

    assert_instance_of Array, results
    assert_equal 1, results.count
    assert_instance_of Integer, results.first.id
    assert_equal 814, results.first.id
    assert_equal 12, results.first.invoice_id
  end

  def test_it_can_find_customer_by_id
     se = SalesEngine.from_csv({
      :items         => "./data/items.csv",
      :merchants     => "./data/merchants.csv",
      :invoices      => "./test/fixtures/invoices_truncated.csv",
      :invoice_items => "./data/invoice_items.csv",
      :transactions  => "./data/transactions.csv",
      :customers     => "./data/customers.csv"
    })

    ir = InvoiceRepo.new(se, "./test/fixtures/invoices_truncated.csv")

    results = ir.find_customer_by_id(12)

    assert_instance_of Integer, results.id
    assert_equal 12, results.id
    assert_equal "Ilene", results.first_name
    assert_equal "Pfannerstill", results.last_name
    assert_instance_of Customer, results

  end

  def test_inspect_shortens_output
    se = SalesEngine.from_csv({
      :items         => "./data/items.csv",
      :merchants     => "./data/merchants.csv",
      :invoices      => "./test/fixtures/invoices_truncated.csv",
      :invoice_items => "./data/invoice_items.csv",
      :transactions  => "./data/transactions.csv",
      :customers     => "./data/customers.csv"
    })

    ir = InvoiceRepo.new(se, "./test/fixtures/invoices_truncated.csv")

    assert_equal "#<InvoiceRepo 163 rows>", ir.inspect
  end
end
