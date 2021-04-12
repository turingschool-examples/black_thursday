require_relative  "test_helper"
require './lib/invoice_items_repository.'

class InvoiceItemsRepositoryTest <  Minitest::Test

  def test_it_exists
    ir = InvoiceItemsRepository.new('./data/items_tiny.csv', self)
    assert_instance_of InvoiceItemsRepository, ir
  end

end
