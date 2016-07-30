require "./test/test_helper"
require "./lib/invoice_item_repo"

class InvoiceItemRepoTest < Minitest::Test

  def setup
    @filepath = "./data/support/invoice_items_support.csv"
    @parent = Minitest::Mock.new
  end

  def test_it_can_find_all_invoice_items
    assert_equal 100, InvoiceItemRepo.new(@filepath).all
  end



end
