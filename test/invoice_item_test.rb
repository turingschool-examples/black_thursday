require './test/test_helper'
require './lib/invoice_item'

class InvoiceItemTest < Minitest::Test
  def setup
    @invoice = InvoiceItem.new(id: 6,
                           customer_id: 7,
                           merchant_id: 8,
                           status: 'pending',
                           created_at: '1969-07-20 20:17:40  0600',
                           updated_at: '1969-07-20 20:17:40  0600'
                          )
    end

  def test_it_exists
    assert_instance_of InvoiceItem, @invoice
  end

  def test_it_returns_integer_id
    assert_equal 6, @invoice.id
  end

end
