require 'minitest/autorun'
require 'minitest/pride'
require 'csv'
require 'time'
require 'bigdecimal'
require 'pry'
require 'date'
require_relative '../lib/item'
require_relative '../lib/sales_engine'

class ItemTest < Minitest::Test

  def setup
    # se = SalesEngine.from_csv({
    #         :merchants => './fixtures/merchants_fixtures.csv',
    #         :items     => './fixtures/items_fixtures.csv'
    #         })
    # @ir = se.items
    # @item = @ir.find_by_id(14784142)

    @item = Item.new({
      id: "4",
      name: 'Pencil',
      description: 'You can use it to write',
      unit_price: "1200",
      created_at: '2016-01-11 11:51:37 UTC',
      updated_at: '1995-03-19 10:02:43 UTC',
      merchant_id: "12334105"
      },
      item_repository = nil)
  end

  # def test_merchant_finds_items_merchant
  #will need to initialize item repo + merchant repo to test
  # end

  def test_initalize_organizes_row_value_id
    assert_equal 4, @item.id
  end

  def test_initalize_organizes_row_value_name
    assert_equal "Pencil", @item.name
  end

  def test_initalize_organizes_row_value_description
    assert_equal "You can use it to write", @item.description
  end

  def test_initalize_organizes_row_value_unit_price
    assert @item.unit_price == 12.00
    assert_equal BigDecimal, @item.unit_price.class
  end

  def test_initalize_organizes_row_value_created_at
    assert_equal Time.parse("2016-01-11 11:51:37 UTC"), @item.created_at
  end

  def test_initalize_organizes_row_value_updated_at
    assert_equal Time.parse("1995-03-19 10:02:43 UTC"), @item.updated_at
  end

  def test_initalize_organizes_row_value_merchant
    assert_equal 12334105, @item.merchant_id
  end

  def test_returns_price_in_dollars_formatted_as_float
    assert_equal 12.00, @item.unit_price_per_dollars
    assert_equal Float, @item.unit_price_per_dollars.class
  end

  def test_merchant_returns_items_merchant
    se = SalesEngine.from_csv({
            :merchants => './fixtures/merchants_fixtures.csv',
            :items     => './fixtures/items_fixtures.csv',
            :invoices      => './fixtures/invoices_fixtures.csv',
            :invoice_items => './fixtures/invoice_items_fixtures.csv',
            :transactions  => './fixtures/transactions_fixtures.csv'
            })
    ir = se.items
    item = ir.find_by_id(263395237)
    assert_equal "NatureDots", item.merchant.name
  end
end
