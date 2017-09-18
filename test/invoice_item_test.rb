require 'bigdecimal'
require 'time'

require './test/test_helper'
require './lib/invoice_item'


class InvoiceItemTest < Minitest::Test

  def new_invoice(data)
    Fixture.new_record(:invoice_items, data)
  end

  def invoice_item_344
    Fixture.find_record(:invoice_items, 344)
  end

  def invoice_item_344_expected
    {
      id:           344,
      item_id:      263506360,
      invoice_id:   74,
      quantity:     1,
      unit_price:   BigDecimal.new('87909') / 100,
      created_at:   Time.parse('2012-03-27 14:54:13 UTC'),
      updated_at:   Time.parse('2012-03-27 14:54:13 UTC')
    }
  end



  def test_initialize_takes_a_hash_of_strings
    assert_instance_of InvoiceItem, new_invoice({
      id:         '344',
      item_id:    '263506360',
      invoice_id: '74',
      quantity:   '1',
      unit_price: '87909',
      created_at: '2012-03-27 14:54:13 UTC',
      updated_at: '2012-03-27 14:54:13 UTC'
    })
  end

  def test_it_has_an_Integer_for_an_id
    assert_equal 344, invoice_item_344.id
  end

  def test_it_has_an_item_id
    assert_equal invoice_item_344_expected[:item_id], invoice_item_344.item_id
  end

  def test_it_has_an_invoice_id
    assert_equal invoice_item_344_expected[:invoice_id], invoice_item_344.invoice_id
  end

  def test_it_has_a_quantity
    assert_equal invoice_item_344_expected[:quantity], invoice_item_344.quantity
  end

  def test_it_has_a_unit_price
    assert_equal invoice_item_344_expected[:unit_price], invoice_item_344.unit_price
  end

  def test_it_has_a_Time_created_at
    assert_equal invoice_item_344_expected[:created_at], invoice_item_344.created_at
  end

  def test_it_has_a_Time_updated_at
    assert_equal invoice_item_344_expected[:updated_at], invoice_item_344.updated_at
  end

  def test_unit_price_to_dollars_returns_the_Float_price_of_the_invoice
    dollars = invoice_item_344.unit_price_to_dollars
    assert_instance_of Float, dollars
    assert_equal 879.09, invoice_item_344.unit_price_to_dollars
  end

end
