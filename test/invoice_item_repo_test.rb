require_relative "test_helper"
require_relative "../lib/invoice_item"
require_relative "../lib/sales_engine"

class InvoiceItemRepoTest < Minitest::Test

  def test_it_exists
    se = SalesEngine.from_csv({
      :items         => "./test/fixtures/items_truncated.csv",
      :merchants     => "./test/fixtures/merchants_truncated.csv",
      :invoices      => "./test/fixtures/invoices_truncated.csv",
      :invoice_items => "./test/fixtures/invoice_items_truncated.csv",
      :transactions  => "./test/fixtures/transactions_truncated.csv",
      :customers     => "./test/fixtures/customers_truncated.csv"
    })

    iir = InvoiceItemRepo.new(se, "./test/fixtures/invoice_items_truncated.csv")

    assert_instance_of InvoiceItemRepo, iir
  end

  def test_all_returns_all_invoice_items
    se = SalesEngine.from_csv({
      :items         => "./test/fixtures/items_truncated.csv",
      :merchants     => "./test/fixtures/merchants_truncated.csv",
      :invoices      => "./test/fixtures/invoices_truncated.csv",
      :invoice_items => "./test/fixtures/invoice_items_truncated.csv",
      :transactions  => "./test/fixtures/transactions_truncated.csv",
      :customers     => "./test/fixtures/customers_truncated.csv"
    })

    iir = InvoiceItemRepo.new(se, "./test/fixtures/invoice_items_truncated.csv")

    assert_equal 699, iir.all.count
    iir.all.each do |invoice_item|
      assert_instance_of InvoiceItem, invoice_item
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

    iir = InvoiceItemRepo.new(se, "./test/fixtures/invoice_items_truncated.csv")

    assert_instance_of InvoiceItem, iir.find_by_id(344)
    assert_equal 344, iir.find_by_id(344).id
  end

  def test_find_all_by_item_id_finds_all_by_item_id
    se = SalesEngine.from_csv({
      :items         => "./test/fixtures/items_truncated.csv",
      :merchants     => "./test/fixtures/merchants_truncated.csv",
      :invoices      => "./test/fixtures/invoices_truncated.csv",
      :invoice_items => "./test/fixtures/invoice_items_truncated.csv",
      :transactions  => "./test/fixtures/transactions_truncated.csv",
      :customers     => "./test/fixtures/customers_truncated.csv"
    })

    iir = InvoiceItemRepo.new(se, "./test/fixtures/invoice_items_truncated.csv")

    assert_instance_of Array, iir.find_all_by_item_id(263506360)
    iir.find_all_by_item_id(263506360).each do |invoice_item|
      assert_instance_of InvoiceItem, invoice_item
      assert_equal 263506360, invoice_item.item_id
    end
  end

  def test_find_all_by_invoice_id_finds_all_by_invoice_id
    se = SalesEngine.from_csv({
      :items         => "./test/fixtures/items_truncated.csv",
      :merchants     => "./test/fixtures/merchants_truncated.csv",
      :invoices      => "./test/fixtures/invoices_truncated.csv",
      :invoice_items => "./test/fixtures/invoice_items_truncated.csv",
      :transactions  => "./test/fixtures/transactions_truncated.csv",
      :customers     => "./test/fixtures/customers_truncated.csv"
    })

    iir = InvoiceItemRepo.new(se, "./test/fixtures/invoice_items_truncated.csv")

    assert_instance_of Array, iir.find_all_by_invoice_id(74)
    iir.find_all_by_invoice_id(74).each do |invoice_item|
      assert_instance_of InvoiceItem, invoice_item
      assert_equal 74, invoice_item.invoice_id
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

    iir = InvoiceItemRepo.new(se, "./test/fixtures/invoice_items_truncated.csv")

    assert_instance_of Item, iir.find_item_by_item_id(263500432)
    assert_equal 263500432, iir.find_item_by_item_id(263500432).id
  end
end
