require './test/test_helper'

class InvoiceItemRepositoryTest < Minitest::Test

  def test_it_exists
    iir = InvoiceItemRepository.new('./test/data/invoice_item_sample.csv')
    assert_instance_of InvoiceItemRepository, iir
  end


end
