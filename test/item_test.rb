require_relative 'test_helper.rb'
require_relative '../lib/sales_engine.rb'
require_relative '../lib/item'
require 'bigdecimal'
require 'csv'
class ItemTest < Minitest::Test
  def setup
    @engine = SalesEngine.from_csv({
      items: './data/items.csv',
      merchants: './data/merchants.csv',
      customers: './data/customers.csv',
      invoices: './data/invoices.csv',
      invoice_items: './data/invoice_items.csv',
      transactions: './data/transactions.csv'
    })
  end

  def test_it_exists
    assert_instance_of Item, @engine.items.items.first
  end

  def test_id_returns_the_id
    item_one = @engine.items.all.first

    assert_equal 263395237, item_one.id

    item_two = @engine.items.all.last

    assert_equal 263567474, item_two.id
  end

  def test_name_returns_the_name
    item_one = @engine.items.all.first

    assert_equal "510+ RealPush Icon Set", item_one.name

    item_two = @engine.items.all.last

    assert_equal "Minty Green Knit Crochet Infinity Scarf", item_two.name
  end

  def test_description_returns_the_description
    item_one = @engine.items.all.first

    assert_instance_of String, item_one.description
    assert_equal 2237, item_one.description.length
  end

  def test_unit_price_returns_the_unit_price
    item_one = @engine.items.all.first

    assert_equal 12.00, item_one.unit_price
    assert_instance_of BigDecimal, item_one.unit_price
  end

  def test_created_at_returns_the_time_it_was_created
    item_one = @engine.items.all.first

    assert_equal Time.parse("2016-01-11 09:34:06 UTC"), item_one.created_at
    assert_instance_of Time, item_one.created_at
  end

  def test_updated_at_returns_the_time_it_was_last_updated
    item_one = @engine.items.all.first

    assert_equal Time.parse("2007-06-04 21:35:10 UTC"), item_one.updated_at
    assert_instance_of Time, item_one.updated_at
  end

  def test_unit_price_to_dollars_returns_price_as_a_float
    expected = @engine.items.find_by_id(263397059)

    assert_equal 130.0, expected.unit_price_to_dollars
    assert_instance_of Float, expected.unit_price_to_dollars
  end

end
