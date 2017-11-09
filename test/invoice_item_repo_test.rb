require_relative 'test_helper'
require_relative "../lib/invoice_item_repo"

class InvoiceItemRepoTest < Minitest::Test

  def test_it_initializes
    assert_instance_of InvoiceItemRepository, InvoiceItemRepository.new(self, "./data/invoice_items.csv")
  end

  def test_it_can_create_invoice_item_instances
    invoice_item_repo = InvoiceItemRepository.new(self, "./data/invoice_items.csv")

    assert_instance_of InvoiceItem, invoice_item_repo.invoice_items.first
  end

  def test_it_can_reach_the_invoice_items_instances_through_all
    invoice_item_repo = InvoiceItemRepository.new(self, "./data/invoice_items.csv")

    assert_instance_of InvoiceItem, invoice_item_repo.all.first
  end

  def test_it_can_find_invoice_items_by_id
    invoice_item_repo = InvoiceItemRepository.new(self, "./data/invoice_items.csv")
    results = invoice_item_repo.find_by_id(331)

    assert_equal 263400329, results.item_id
  end

  def test_find_by_id_can_return_nil
    invoice_item_repo = InvoiceItemRepository.new(self, "./data/invoice_items.csv")
    results = invoice_item_repo.find_by_id(30000)

    assert_nil results
  end

  def test_it_can_find_all_by_item_id
    invoice_item_repo = InvoiceItemRepository.new(self, "./data/invoice_items.csv")
    results = invoice_item_repo.find_all_by_item_id(263523644)

    assert_equal 19, results.length
    assert_instance_of Array, results
    assert_instance_of InvoiceItem, results.first
  end

  def test_find_all_by_item_id_can_return_an_empty_array
    invoice_item_repo = InvoiceItemRepository.new(self, "./data/invoice_items.csv")
    results = invoice_item_repo.find_all_by_item_id(000000)

    assert_equal [], results
  end

  def test_it_can_find_all_by_invoice_id
    invoice_item_repo = InvoiceItemRepository.new(self, "./data/invoice_items.csv")
    results = invoice_item_repo.find_all_by_invoice_id(1095)

    assert_equal 6, results.length
    assert_equal 4867, results.first.id
  end

  def test_find_all_by_item_id_can_return_an_empty_array
    invoice_item_repo = InvoiceItemRepository.new(self, "./data/invoice_items.csv")
    results = invoice_item_repo.find_all_by_invoice_id(000000)

    assert_equal [], results
  end

  def test_it_can_find_item_by_item_id
    se = SalesEngine.from_csv({
      :items         => "./data/items.csv",
      :merchants     => "./data/merchants.csv",
      :invoices      => "./data/invoices.csv",
      :invoice_items => "./data/invoice_items.csv",
      :transactions  => "./data/transactions.csv",
      :customers     => "./data/customers.csv"
    })

    invoice_item_repo = InvoiceItemRepository.new(se, "./data/invoice_items.csv")
    results = invoice_item_repo.find_item_by_item_id(263395237)

    assert_equal 263395237, results.id
    assert_equal "510+ RealPush Icon Set", results.name
  end
end
