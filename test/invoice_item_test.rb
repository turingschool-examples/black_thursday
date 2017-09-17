require 'bigdecimal'
require 'time'

require './test/test_helper'
return
require './lib/invoice_item'

class InvoiceItemTest < Minitest::Test

  def new_invoice(data)
    Fixture.new_record(:invoiceitem, data)
  end

  def invoice_item_263519844
    Fixture.find_record(:invoiceitem, 263519844)
  end

  def invoice_item_263519844_expected
    {
      id:           1,
      item_id: 263519844,
      invoice_id:   1,
      quantity:  5,
      unit_price:   BigDecimal.new('13635'),
      created_at:   Time.parse('2012-03-27 14:54:09 UTC'),
      updated_at:   Time.parse('2012-03-27 14:54:09 UTC')
    }
  end

  def test_initialize_takes_a_hash_of_strings
    assert_instance_of InvoiceItem, new_invoice({
      id:           '1',
      item_id: '263519844',
      invoice_id:   '1',
      quantity:  '5',
      unit_price:  '13635',
      created_at:  '2012-03-27 14:54:09 UTC',
      updated_at:  '2012-03-27 14:54:09 UTC'
      })
  end

  def test_it_has_an_Integer_for_an_id
    assert_equal 1 , invoice_item_263519844.id
  end

  def test_it_has_an_item_id
    assert_equal invoice_item_263519844_expected[:item_id], invoice_item_263519844.item_id
  end

  def test_it_has_an_invoice_id
    assert_equal invoice_item_263519844_expected[:invoice_id], invoice_item_263519844.invoice_id
  end

  def test_it_has_a_quantity
    assert_equal invoice_item_263519844_expected[:quantity], invoice_item_263519844.quantity
  end

  def test_it_has_a_unit_price
    assert_equal invoice_item_263519844_expected[:unit_price], invoice_item_263519844.quantity
  end

  def test_it_has_a_Time_created_at
    assert_equal invoice_item_263519844_expected[:created_at], invoice_item_263519844.created_at
  end

  def test_it_has_a_Time_updated_at
    assert_equal invoice_item_263519844_expected[:updated_at], invoice_item_263519844.updated_at
  end

  def test_unit_price_to_dollars_returns_the_price_of_the_invoice
    assert_equal 10.99 , invoice_item_263519844.unit_price_to_dollars
  end

end
