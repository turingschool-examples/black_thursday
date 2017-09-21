require_relative 'test_helper'
require_relative '../lib/item'
require_relative '../lib/sales_engine'
require 'bigdecimal'

class ItemTest < Minitest::Test

  def setup
    se = SalesEngine.from_csv({
    :items     => "./test/fixtures/items_fixture.csv",
    :merchants => "./test/fixtures/merchants_fixture.csv",
    :invoices => "./test/fixtures/invoices_fixture.csv",
    :transactions => "./test/fixtures/transactions_fixture.csv",
    :invoice_items => './test/fixtures/invoice_items_fixture.csv',
    :customers => "./test/fixtures/customers_fixture.csv"
    })
    se.merchants
    se.transactions
    se.invoice_items
    se.customers
    se.invoices
    @ir = se.items
  end

  def test_it_exists
    assert_instance_of Item, @ir.items[0]
  end

  def test_it_displays_id

    assert_equal 263403127, @ir.items[0].id
  end

  def test_it_has_a_name

    assert_equal "Knitted winter snood", @ir.items[0].name
  end

  def test_it_has_a_description

    description = 'Free standing wooden Any colours'

    assert_equal description, @ir.items[3].description
  end

  def test_it_has_a_unit_price

    assert_instance_of BigDecimal, @ir.items[3].unit_price
  end

  def test_it_has_a_created_at_time

    assert_instance_of Time, @ir.items[3].created_at
  end

  def test_it_has_an_updated_at_time

    assert_instance_of Time, @ir.items[3].updated_at
  end

  def test_it_has_a_merchant_id

    assert_equal 12334185, @ir.items[3].merchant_id
  end

  def test_it_can_be_assigned_a_merchant

    item = @ir.find_by_id(263403127)
    seller = item.merchant

    assert_equal 12334403, seller.id
    assert_equal 'IOleynikova', seller.name
  end

  def test_it_can_be_connected_with_invoice_items

    item = @ir.find_by_id(263403127)
    assert_instance_of InvoiceItem, item.invoice_items.first
  end

end
