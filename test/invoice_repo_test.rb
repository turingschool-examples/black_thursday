require_relative "test_helper"
require_relative "../lib/invoice_repo"
require_relative "../lib/sales_engine"

class InvoiceRepoTest < Minitest::Test

  def test_it_exist
    se = SalesEngine.from_csv({
        :items         => "./data/items.csv",
        :merchants     => "./data/merchants.csv",
        :invoices      => "./data/invoices.csv",
        :invoice_items => "./data/invoice_items.csv",
        :transactions  => "./data/transactions.csv",
        :customers     => "./data/customers.csv"
      })

    invoice_repo = InvoiceRepo.new(se, "./data/invoices.csv")

    assert_instance_of InvoiceRepo, invoice_repo
  end

  def test_it_can_create_invoice_instances
    se = SalesEngine.from_csv({
        :items         => "./data/items.csv",
        :merchants     => "./data/merchants.csv",
        :invoices      => "./data/invoices.csv",
        :invoice_items => "./data/invoice_items.csv",
        :transactions  => "./data/transactions.csv",
        :customers     => "./data/customers.csv"
      })

    invoice_repo = InvoiceRepo.new(se, "./data/invoices.csv")

    assert_instance_of Invoice, invoice_repo.invoices.first
  end

  def test_it_can_reach_the_invoice_instances_through_all
    se = SalesEngine.from_csv({
        :items         => "./data/items.csv",
        :merchants     => "./data/merchants.csv",
        :invoices      => "./data/invoices.csv",
        :invoice_items => "./data/invoice_items.csv",
        :transactions  => "./data/transactions.csv",
        :customers     => "./data/customers.csv"
      })

    invoice_repo = InvoiceRepo.new(se, "./data/invoices.csv")

    assert_instance_of Invoice, invoice_repo.all.first
  end

end



















