require_relative 'test_helper'
require_relative '../lib/item_repository'
require_relative '../lib/sales_engine'
require_relative '../lib/merchant_repository'
require 'pry'
require 'time'

class ItemTest < MiniTest::Test

  def setup
    @sales_engine = SalesEngine.from_csv({
      :items => './test/fixtures/items_fixture.csv',
      :merchants => './test/fixtures/merchants.csv',
      :invoices => './test/fixtures/invoices.csv',
      :invoice_items => './test/fixtures/invoice_items.csv',
      :transactions => './test/fixtures/transactions.csv',
      :customers => './test/fixtures/customers.csv'})
    @items = @sales_engine.items
    @merchants = @sales_engine.merchants
  end

  def test_it_has_attributes
    item1 = @items.all[0]

    assert_equal "Amy Winehouse drawing print", item1.name
    assert_equal 12334112, item1.merchant_id
    assert_equal 263401607, item1.id
    assert_equal "Print of ink drawing on card of amy winehouse A4 or A5 prints available",
    item1.description
    assert_equal 20.00, item1.unit_price
    assert_equal Time.parse("2016-01-11 12:22:31 UTC"), item1.created_at
    assert_equal Time.parse("1978-10-14 18:48:11 UTC"), item1.updated_at
  end

  def test_it_knows_where_it_came_from
    item = @items.items.first

    assert_equal @items, item.repository
  end

  def test_it_can_find_a_merchant
    item = @sales_engine.merchants.find_by_id(12334123)

    assert_instance_of Merchant, item
    assert_equal "Kecken--bauer", item.name
  end

end
