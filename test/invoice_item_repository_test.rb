
gem 'minitest', '~> 5.2'
require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/invoice_item'
require_relative '../lib/invoice_item_repository'
require_relative '../lib/sales_engine'

class InvoiceItemRepositoryClassTest < Minitest::Test

  def setup
    sales_engine = "sales_engine"
    @invoice_items = InvoiceItemRepository.new(sales_engine)

    @invoice_items.repository << InvoiceItem.new(sales_engine, {:id => "1",
                                            :item_id => "263519844",
                                            :invoice_id => "1",
                                            :quantity => '5',
                                            :unit_price => '13635',
                                            :created_at => '2012-03-27 14:54:09 UTC',
                                            :updated_at => '2012-03-27 14:54:09 UTC'})
    @invoice_items.repository << InvoiceItem.new(sales_engine, {:id => "2",
                                            :item_id => "263454779",
                                            :invoice_id => "1",
                                            :quantity => '9',
                                            :unit_price => '23324',
                                            :created_at => '2012-03-27 14:54:09 UTC',
                                            :updated_at => '2012-03-27 14:54:09 UTC'})
  end

  def test_we_can_create_an_invoice_repository
    assert @invoice_items
    assert_equal 2, @invoice_items.all.count
  end

  def test_we_can_find_invoice_items_by_id
    assert_equal Array, @invoice_items.find_all_by_item_id(263519844).class
    assert_equal 263519844, @invoice_items.find_by_id(1).item_id
    assert_equal  263454779, @invoice_items.find_by_id(2).item_id
  end

  def test_we_can_find_all_by_item_id
    assert_equal 1, @invoice_items.find_all_by_item_id(263519844)[0].id
    assert_equal 2, @invoice_items.find_all_by_item_id(263454779)[0].id
  end

  def test_we_can_find_all_by_invoice_id
    assert_equal [1, 2], @invoice_items.find_all_by_invoice_id(1).map { |invoice_item| invoice_item.id}
  end
end
