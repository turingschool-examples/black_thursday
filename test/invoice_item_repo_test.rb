require "./test/test_helper"
require "./lib/invoice_item_repo"

class InvoiceItemRepoTest < Minitest::Test

  def setup
    @filepath = "./data/support/invoice_items_support.csv"
    @parent = Minitest::Mock.new
  end

  def test_it_can_find_all_invoice_items
    assert_equal 208, InvoiceItemRepo.new(@filepath).all.count
  end

  def test_it_can_find_by_id
    invoice_item_repo = InvoiceItemRepo.new(@filepath)
    assert_equal 2, invoice_item_repo.find_by_id(10).invoice_id
  end

  def test_it_can_find_all_by_item_id
    invoice_item_repo = InvoiceItemRepo.new(@filepath)
    assert_equal 1,invoice_item_repo.find_all_by_item_id(263523644).count
  end

  def test_it_can_find_all_by_invoice_id
    invoice_item_repo = InvoiceItemRepo.new(@filepath)
    assert_equal 8, invoice_item_repo.find_all_by_invoice_id(3).count
  end

end
