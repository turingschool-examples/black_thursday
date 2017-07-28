require './test/test_helper'
require './lib/invoice_item_repository'

class InvoiceItemRepositoryTest < Minitest::Test

  def test_it_exists
    iir = InvoiceItemRepository.new('./data/invoice_items_short.csv', self)

    assert_instance_of InvoiceItemRepository, iir
  end
end
