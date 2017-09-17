 require './test/test_helper'

 require './lib/invoice_item_repository'


 class InvoiceItemRepositoryTest < Minitest::Test

   attr_reader :invoice_item_repo

  def setup
    @invoice_item_repo = Fixture.repo(:InvoiceItem)
  end

  def test_that_an_instance_exits
    assert_instance_of InvoiceItemRepository, invoice_item_repo
  end

  def test_all_returns_an_array_of_all_Invoice_item_instances
    assert_instance_of Array, invoice_item_repo
    assert_instance_of InvoiceItem, invoice_item_repo.all.first
  end

  def test_find_by_id_returns_nil_if_no_matching_id
    assert_nil invoice_item_repo.find_by_id(200)
  end

  def test_find_by_id_returns_invoice_item_instance
    invoiceitem = invoice_item_repo.find_by_id(1)
    assert_instance_of InvoiceItem, invoiceitem

    assert_equal 1, invoiceitem.id
  end

  def test_find_all_by_item_id_returns_an_empty_array_with_no_match
    assert_equal [], invoice_item_repo.find_all_by_item_id(00)
  end

  def test_find_all_by_item_id_returns_all_that_match_the_id
    assert_equal 2, invoice_item_repo.find_all_by_item_id(1).count
  end

  def test_find_all_by_invoice_id_returns_an_empty_array_with_no_match
    assert_equal [], invoice_item_repo.find_all_by_invoice_id(00)
  end

  def test_find_all_by_invoice_id_returns_all_that_match_the_id
    assert_equal 3, invoice_item_repo.find_all_by_invoice_id(2).count
  end
end
