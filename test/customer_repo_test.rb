require_relative "test_helper"
require_relative "../lib/customer_repo"
require_relative "../lib/sales_engine"

class CustomerRepoTest < Minitest::Test

  def test_it_exists
    se = SalesEngine.from_csv({
      :items         => "./test/fixtures/items_truncated.csv",
      :merchants     => "./test/fixtures/merchants_truncated.csv",
      :invoices      => "./test/fixtures/invoices_truncated.csv",
      :invoice_items => "./test/fixtures/invoice_items_truncated.csv",
      :transactions  => "./test/fixtures/transactions_truncated.csv",
      :customers     => "./test/fixtures/customers_truncated.csv"
    })

    cr = CustomerRepo.new(se, "./test/fixtures/customers_truncated.csv")

    assert_instance_of CustomerRepo, cr
    assert_equal 1, cr.customers.first.id
    assert_equal "Joey", cr.customers.first.first_name
    assert_equal 50, cr.customers.count
  end

  def test_all_returns_all_customers
    se = SalesEngine.from_csv({
      :items         => "./test/fixtures/items_truncated.csv",
      :merchants     => "./test/fixtures/merchants_truncated.csv",
      :invoices      => "./test/fixtures/invoices_truncated.csv",
      :invoice_items => "./test/fixtures/invoice_items_truncated.csv",
      :transactions  => "./test/fixtures/transactions_truncated.csv",
      :customers     => "./test/fixtures/customers_truncated.csv"
    })

    cr = CustomerRepo.new(se, "./test/fixtures/customers_truncated.csv")

    assert_instance_of Array, cr.all
    assert_equal 50, cr.all.count
    cr.all.each do |customer|
      assert_instance_of Customer, customer
    end
  end

  def test_find_by_id_finds_by_id
    se = SalesEngine.from_csv({
      :items         => "./test/fixtures/items_truncated.csv",
      :merchants     => "./test/fixtures/merchants_truncated.csv",
      :invoices      => "./test/fixtures/invoices_truncated.csv",
      :invoice_items => "./test/fixtures/invoice_items_truncated.csv",
      :transactions  => "./test/fixtures/transactions_truncated.csv",
      :customers     => "./test/fixtures/customers_truncated.csv"
    })

    cr = CustomerRepo.new(se, "./test/fixtures/customers_truncated.csv")

    assert_instance_of Customer, cr.find_by_id(1)
    assert_equal 1, cr.find_by_id(1).id
  end

  def test_find_all_by_first_name_finds_all_by_first_name
    se = SalesEngine.from_csv({
      :items         => "./test/fixtures/items_truncated.csv",
      :merchants     => "./test/fixtures/merchants_truncated.csv",
      :invoices      => "./test/fixtures/invoices_truncated.csv",
      :invoice_items => "./test/fixtures/invoice_items_truncated.csv",
      :transactions  => "./test/fixtures/transactions_truncated.csv",
      :customers     => "./test/fixtures/customers_truncated.csv"
    })

    cr = CustomerRepo.new(se, "./test/fixtures/customers_truncated.csv")

    assert_instance_of Array, cr.find_all_by_first_name("Joey")
    cr.find_all_by_first_name("Joey").each do |customer|
      assert_instance_of Customer, customer
      assert_equal "Joey", customer.first_name
    end
  end

  def test_find_all_by_last_name_finds_all_by_last_name
    se = SalesEngine.from_csv({
      :items         => "./test/fixtures/items_truncated.csv",
      :merchants     => "./test/fixtures/merchants_truncated.csv",
      :invoices      => "./test/fixtures/invoices_truncated.csv",
      :invoice_items => "./test/fixtures/invoice_items_truncated.csv",
      :transactions  => "./test/fixtures/transactions_truncated.csv",
      :customers     => "./test/fixtures/customers_truncated.csv"
    })

    cr = CustomerRepo.new(se, "./test/fixtures/customers_truncated.csv")

    assert_instance_of Array, cr.find_all_by_last_name("Smith")
    cr.find_all_by_last_name("Smith").each do |customer|
      assert_instance_of Customer, customer
      assert_includes customer.last_name, "Smith"
    end
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

    cr = CustomerRepo.new(se, "./test/fixtures/customers_truncated.csv")

    assert_instance_of Array, cr.find_invoices_by_customer_id(1)
    cr.find_invoices_by_customer_id(1).each do |invoice|
      assert_instance_of Invoice, invoice
      assert_equal 1, invoice.customer_id
    end
  end
end
