require_relative 'test_helper'
require_relative "../lib/invoice_repo"

class InvoiceRepoTest < Minitest::Test

  def test_it_initializes
    assert_instance_of InvoiceRepository, InvoiceRepository.new(self, "./data/invoices.csv")
  end

  def test_it_can_create_invoice_instances
    invoice_repo = InvoiceRepository.new(self, "./data/invoices.csv")

    assert_instance_of Invoice, invoice_repo.invoices.first
  end

  def test_it_can_reach_the_invoice_instances_through_all
    invoice_repo = InvoiceRepository.new(self, "./data/invoices.csv")

    assert_instance_of Invoice, invoice_repo.all.first
  end

  def test_it_can_find_invoices_by_id
    invoice_repo = InvoiceRepository.new(self, "./data/invoices.csv")
    results = invoice_repo.find_by_id(3311)

    assert_equal 12335660, results.merchant_id
  end

  def test_it_can_find_invoices_by_customer_id
    invoice_repo = InvoiceRepository.new(self, "./data/invoices.csv")
    results = invoice_repo.find_all_by_customer_id(300)

    assert_equal 10, results.length
  end

  def test_find_by_customer_id_can_return_an_empty_array
    invoice_repo = InvoiceRepository.new(self, "./data/invoices.csv")
    results = invoice_repo.find_all_by_customer_id(000000)

    assert_equal [], results
  end

  def test_it_can_find_all_by_merchant_id
    invoice_repo = InvoiceRepository.new(self, "./data/invoices.csv")
    results = invoice_repo.find_all_by_merchant_id(12334185)

    assert_equal 10, results.count
    assert_equal 1495, results.first.id
  end

  def test_find_by_merchant_id_can_return_an_empty_array
    invoice_repo = InvoiceRepository.new(self, "./data/invoices.csv")
    results = invoice_repo.find_all_by_merchant_id(000000)

    assert_equal [], results
  end

  def test_find_by_invoices_by_status
    invoice_repo = InvoiceRepository.new(self, "./data/invoices.csv")
    results = invoice_repo.find_all_by_status(:pending)

    assert_equal 1473, results.length
  end

  def test_find_by_status_can_return_an_empty_array
    invoice_repo = InvoiceRepository.new(self, "./data/invoices.csv")
    results = invoice_repo.find_all_by_status(:received)

    assert_equal [], results
  end

  def test_it_can_find_all_by_created_date
    invoice_repo = InvoiceRepository.new(self, "./data/invoices.csv")
    results = invoice_repo.find_all_by_created_date(Time.parse("2009-02-07"))

    assert_equal 1, results.count
    assert_equal 1, results.first.id
    assert_equal 12335938, results.first.merchant_id
  end

  def test_it_can_find_merchant_by_id
    se = SalesEngine.from_csv({
      :items         => "./data/items.csv",
      :merchants     => "./data/merchants.csv",
      :invoices      => "./data/invoices.csv",
      :invoice_items => "./data/invoice_items.csv",
      :transactions  => "./data/transactions.csv",
      :customers     => "./data/customers.csv"
    })

    invoice_repo = InvoiceRepository.new(se, "./data/invoices.csv")
    results = invoice_repo.find_merchant(12335938)

    assert_equal 12335938, results.id
  end

  def test_it_can_find_items_by_invoice_id
    se = SalesEngine.from_csv({
      :items         => "./data/items.csv",
      :merchants     => "./data/merchants.csv",
      :invoices      => "./data/invoices.csv",
      :invoice_items => "./data/invoice_items.csv",
      :transactions  => "./data/transactions.csv",
      :customers     => "./data/customers.csv"
    })

    invoice_repo = InvoiceRepository.new(se, "./data/invoices.csv")
    results = invoice_repo.find_items_by_invoice_id(25)

    assert_equal 3, results.count
  end

  def test_it_can_find_transactions_by_invoice_id
    se = SalesEngine.from_csv({
      :items         => "./data/items.csv",
      :merchants     => "./data/merchants.csv",
      :invoices      => "./data/invoices.csv",
      :invoice_items => "./data/invoice_items.csv",
      :transactions  => "./data/transactions.csv",
      :customers     => "./data/customers.csv"
    })

    invoice_repo = InvoiceRepository.new(se, "./data/invoices.csv")
    results = invoice_repo.find_transactions_by_invoice_id(1)

    assert_equal 2, results.count
    assert_equal 2650, results.first.id
    assert_equal 4351, results.last.id
  end

  def test_it_can_find_customer_by_customer_id
    se = SalesEngine.from_csv({
      :items         => "./data/items.csv",
      :merchants     => "./data/merchants.csv",
      :invoices      => "./data/invoices.csv",
      :invoice_items => "./data/invoice_items.csv",
      :transactions  => "./data/transactions.csv",
      :customers     => "./data/customers.csv"
    })

    invoice_repo = InvoiceRepository.new(se, "./data/invoices.csv")
    results = invoice_repo.find_customer_by_customer_id(1)

    assert_equal 1, results.id
    assert_equal "Joey", results.first_name
  end

  def test_it_can_find_invoice_items_by_invoice_id
    se = SalesEngine.from_csv({
      :items         => "./data/items.csv",
      :merchants     => "./data/merchants.csv",
      :invoices      => "./data/invoices.csv",
      :invoice_items => "./data/invoice_items.csv",
      :transactions  => "./data/transactions.csv",
      :customers     => "./data/customers.csv"
    })

    invoice_repo = InvoiceRepository.new(se, "./data/invoices.csv")
    results = invoice_repo.find_invoice_items_by_invoice_id(1)

    assert_equal 8, results.count
    assert_equal 263519844, results.first.item_id
    assert_equal 263432817, results.last.item_id
  end
end
