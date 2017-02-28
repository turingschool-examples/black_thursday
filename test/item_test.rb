require './test/test_helper'
require './lib/item'
require_relative '../lib/sales_engine'
require_relative '../lib/item_repository'

class ItemTest < Minitest::Test
  def setup
    @se = SalesEngine.from_csv({
      :merchants => "./data/merchants.csv",
      :items     => "./data/items.csv",
      :customers => "./data/customers.csv",
      :invoices  => "./data/invoices.csv",
      :invoice_items => "./data/invoice_items.csv",
      :transactions  => "./data/transactions.csv"
      })

    @i = Item.new({
      :name        => "Pencil",
      :description => "You can use it to write things",
      :unit_price  => BigDecimal.new(10.99,4),
      :created_at  => "2016-01-11 11:44:00 UTC",
      :updated_at  => "2006-08-26 06:56:21 UTC"
      }, @se.items)
  end

  def test_assert_it_exists
    assert_instance_of Item, @i
  end

  def test_every_item_has_a_item_repo_parent
    assert @i.parent, @se.items

  end

  # def test_it_has_id
  #   assert_equal 5, @i.id
  # end

  # def test_it_returns_integer_id_of_item
  #   # method #id
  #   # returns the integer id of the item
  # end

  def test_it_returns_name_of_item
    assert_equal "Pencil", @i.name
  end

  def test_it_returns_description_of_item
    assert_equal "You can use it to write things", @i.description
  end

  def test_it_returns_unit_price
    assert_instance_of BigDecimal, @i.unit_price
  end

  def test_it_returns_unit_price_to_dollars
    assert_instance_of Float, @i.unit_price_to_dollars
  end

  def test_it_returns_instance_of_time_for_date_item_was_first_created
    assert_instance_of Time, @i.created_at
  end

  def test_it_returns_instance_of_time_for_date_item_was_last_modified
    assert_instance_of Time, @i.updated_at
  end

  # def test_it_returns_integer_id_of_merchant_of_item
  #   # method #merchant_id
  #   # returns the integer merchant id of the item
  # end
end
