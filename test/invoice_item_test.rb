require 'minitest/autorun'
require 'minitest/pride'
require './lib/invoice_item_repository'
require './lib/invoice_item'
require 'time'
require 'bigdecimal'
require './lib/sales_engine'
require './lib/sales_analyst'

class InvoiceItemTest < Minitest::Test
  def setup
    merchant_path = './data/merchants.csv'
    item_path = './data/items.csv'
    invoice_items_path = './data/invoice_items.csv'
    locations = { items: item_path,
                  merchants: merchant_path,
                  invoice_items: invoice_items_path}
    @engine = SalesEngine.new(locations)
    @invoice_items_repo = InvoiceItemRepository.new('./data/invoice_items.csv', @engine)
    @ii = InvoiceItem.new({
                          :id => 6,
                          :item_id => 7,
                          :invoice_id => 8,
                          :quantity => 1,
                          :unit_price => BigDecimal(10.99, 4),
                          :created_at => "#{Time.now}",
                          :updated_at => "#{Time.now}"
                        },@invoice_items_repo)
  end

  def test_it_exists_and_has_attributes
    assert_instance_of InvoiceItem, @ii
    assert_equal 6, @ii.id
    assert_equal 7, @ii.item_id
    assert_equal 1, @ii.quantity
    assert_equal BigDecimal(10.99, 4) / 100, @ii.unit_price
    assert_instance_of Time, @ii.created_at
    assert_instance_of Time, @ii.updated_at
    assert_instance_of InvoiceItemRepository, @ii.invoice_items_repo
    assert_equal 10.99, @ii.unit_price_to_dollars * 100
  end
end
