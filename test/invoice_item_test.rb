require 'minitest'
require 'minitest/autorun'
require 'minitest/emoji'
require './lib/invoice_item'

class InvoiceItemTest < Minitest::Test

  def test_it_exists
    i = InvoiceItem.new({id:1}, 1)
    assert i
    assert_instance_of InvoiceItem, i
  end

  def setup
    hash = {id: 1, item_id: 3, invoice_id: 4,
            quantity: :Closed, unit_price: 1200,
            created_at: "2012-11-23", updated_at: "2013-04-14"}
    @in_item = InvoiceItem.new(hash, 1)
  end

  def test_id_can_be_got
    assert_equal 1, @in_item.id
  end

  def test_item_id_can_be_got
    assert_equal 3, @in_item.item_id
  end

  def test_invoice_id_can_be_got
  end

  def test_quantitity_can_be_got
  end

  def test_unit_price_can_be_got
  end

  def test_created_at_can_be_got
  end

  def test_updated_at_can_be_got
  end

end
