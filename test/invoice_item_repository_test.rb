require './test/test_helper'
require './lib/invoice_item_repository'

class InvoiceItemRepositoryTest < Minitest::Test
  attr_reader :invoice_item_repository

  def setup
    @invoice_item_repository = InvoiceItemRepository.new
      # ir.from_csv("./data/invoice_items.csv")
      # invoice = ir.find_by_id(6)
  end

  def test_that_it_exists
    assert_instance_of InvoiceItemRepository, invoice_item_repository
  end
end
