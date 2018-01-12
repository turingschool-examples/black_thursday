require 'bigdecimal'
require 'time'
require_relative '../test/test_helper'
require_relative '../lib/invoice_item'

class InvoiceItemTest < Minitest::Test

  attr_reader :invoice_item

  def setup
    invoice_item_data = ({
      :id         => 6,
      :item_id    => 7,
      :invoice_id => 8,
      :quantity   => 1,
      :unit_price => 10.99,
      :created_at => "2018-01-07 09:22:04 -0700",
      :updated_at => "2015-02-18 09:22:04 -0700"})
      parent = mock('repository')
    @invoice_item = InvoiceItem.new(invoice_item_data, parent)
  end

  def test_it_exists
    assert_instance_of InvoiceItem, invoice_item
  end

  def test_it_has_attributes
    assert_equal 6, invoice_item.id
    assert_equal 7, invoice_item.item_id
    assert_equal 8, invoice_item.invoice_id
    assert_equal 1, invoice_item.quantity
    assert_equal BigDecimal.new(10.99, 4) / 100, invoice_item.unit_price
    assert_equal Time.parse("2018-01-07 09:22:04 -0700"), invoice_item.created_at
    assert_equal Time.parse("2015-02-18 09:22:04 -0700"), invoice_item.updated_at
    assert_equal 10.99, invoice_item.unit_price_to_dollars
  end

  def test_finds_invoice_item_by_id
    invoice_item_1 = mock("Invoice_Item")
    invoice_item_2 = mock("Invoice_Item")
    invoice_item_3 = mock("Invoice_Item")
    invoice_item.inv_item_repo.stubs(:find_by_id).with(13).returns([invoice_item_1, invoice_item_2, invoice_item_3])

    assert_equal 3, @invoice_item.id.count
    invoice_item.id.each do |invoice_id|
      assert_instance_of Mocha::Mock, invoice_id
    end
  end



end
