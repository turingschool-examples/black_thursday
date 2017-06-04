require_relative 'test_helper'
require_relative '../lib/invoice_item_repository'

class InvoiceItemRepositoryTest < Minitest::Test


  def test_it_creates_class
    iir = InvoiceItemRepository.new

    assert_instance_of InvoiceItemRepository, iir
  end

end
