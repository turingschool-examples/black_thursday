require_relative 'test_helper'
require_relative '../lib/item_repository'
require_relative '../lib/sales_engine'
require_relative '../lib/merchant_repository'
require 'pry'

class ItemTest < MiniTest::Test

  def setup
    @sales_engine = SalesEngine.from_csv({
      :items => './test/fixtures/items_fixture.csv',
      :merchants => './test/fixtures/merchants.csv',
      :invoices => './test/fixtures/invoices.csv'
      })
    @items = @sales_engine.items
    @merchants = @sales_engine.merchants
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
