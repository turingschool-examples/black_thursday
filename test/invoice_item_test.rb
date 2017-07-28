require 'minitest'
require 'minitest/autorun'
require 'minitest/emoji'
require './lib/invoice_item'

class InvoiceItemTest < Minitest::Test

  def test_it_exists
    i = InvoiceItem.new(1, 1)
    assert i
    assert_instance_of InvoiceItem, i
  end

  def setup
    hash = {id: 1, item_id: 3, invoice_id: 4,
            quantity: :Closed, unit_price: 1200
            created_at: "2012-11-23", updated_at: "2013-04-14"}
    @in_v = Invoice.new(hash, 1)
  end

  def test_it_can_be


end
