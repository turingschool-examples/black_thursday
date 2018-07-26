require_relative 'test_helper'
require_relative '../lib/invoice_item_repository'
require_relative '../lib/invoice_item'

class InvoiceItemRepositoryTest < Minitest::Test

  def setup
    @invoice_item_1 = InvoiceItem.new({:id => 6, :item_id => 7, :invoice_id => 88, :quantity => 1, :unit_price => BigDecimal.new(100.99, 4), :created_at => Time.now, :updated_at => Time.now})
    @invoice_item_2 = InvoiceItem.new({:id => 7, :item_id => 7, :invoice_id => 99, :quantity => 1, :unit_price => BigDecimal.new(5.99, 4), :created_at => Time.now, :updated_at => Time.now})
    @invoice_item_3 = InvoiceItem.new({:id => 8, :item_id => 7, :invoice_id => 77, :quantity => 1, :unit_price => BigDecimal.new(12.36, 4), :created_at => Time.now, :updated_at => Time.now})
    @invoice_item_4 = InvoiceItem.new({:id => 9, :item_id => 7, :invoice_id => 66, :quantity => 1, :unit_price => BigDecimal.new(9.79, 4), :created_at => Time.now, :updated_at => Time.now})
    @invoice_items = [@invoice_item_1, @invoice_item_2, @invoice_item_3, @invoice_item_4]
    @invoice_item_repository = InvoiceItemRepository.new(@invoice_items)
  end

  def test_it_exists
    assert_instance_of InvoiceItemRepository, @invoice_item_repository
  end

end
