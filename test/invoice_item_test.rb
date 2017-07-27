require_relative '../lib/sales_engine'
require 'bigdecimal'
require 'time'
require_relative '../lib/invoice_item'
require 'csv'
require 'minitest/autorun'
require 'minitest/emoji'

class InvoiceItemTest < Minitest::Test
  def setup
    @se = SalesEngine.from_csv({
              :items => "./test/data/items_fixture.csv",
              :merchants => "./test/data/merchants_fixture.csv",
              :invoice_items => "./test/data/invoice_items_fixture.csv",
              :invoices => "./test/data/invoices_fixture.csv",
              :transactions => "./test/data/transactions_fixture.csv",
              :customers => "./test/data/customers_fixture.csv"
            })
    @ii = InvoiceItem.new({
              :id => 6,
              :item_id => 7,
              :invoice_id => 8,
              :quantity => 1,
              :unit_price => BigDecimal.new(10.99, 4),
              :created_at => Time.now,
              :updated_at => Time.now
            }, @se.invoice_items)
  end

  def test_it_exists
    assert_instance_of InvoiceItem, @ii
  end


end
