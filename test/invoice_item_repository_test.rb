require_relative '../lib/invoice_item_repository'
require_relative '../lib/invoice_item'
require_relative './test_helper'

class InvoiceItemRepositoryTest < Minitest::Test

  def setup
    @invoice_items =
    [
      { id: 1,
        item_id: 263519844,
        invoice_id: 1,
        quantity: 5,
        unit_price: 13635,
        created_at: '2012-03-27 14:54:09 UTC',
        updated_at: '2012-03-27 14:54:09 UTC'},
      { id: 1,
        item_id: 263519844,
        invoice_id: 1,
        quantity: 5,
        unit_price: 13635,
        created_at: '2012-03-27 14:54:09 UTC',
        updated_at: '2012-03-27 14:54:09 UTC'},
      { id: 1,
        item_id: 263519844,
        invoice_id: 1,
        quantity: 5,
        unit_price: 13635,
        created_at: '2012-03-27 14:54:09 UTC',
        updated_at: '2012-03-27 14:54:09 UTC'}
    ]
    @iir = InvoiceItemRepository.new(@invoice_items)
  end
  def test_it_exists

  end

end
