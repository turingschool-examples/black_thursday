require_relative 'test_helper'
require_relative '../lib/invoice_item_repository'

class InvoiceItemRepositoryTest < Minitest::Test

  def test_invoice_item_repository_exists
    iir = InvoiceItemRepository.new("./data/invoice_items.csv", self)

    assert_instance_of InvoiceItemRepository, iir
  end

end
