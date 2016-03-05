require 'minitest/autorun'
require 'minitest/pride'
require 'csv'
require 'time'
require 'bigdecimal'
require 'pry'
require 'date'
require_relative '../lib/invoice_item'
require_relative '../lib/sales_engine'

class InvoiceItemTest < Minitest::Test

  def setup
    # se = SalesEngine.from_csv({
    #         :merchants => './fixtures/merchants_fixtures.csv',
    #         :items     => './fixtures/items_fixtures.csv'
    #         })
    # @ir = se.items
    # @invoice_item = @ir.find_by_id(14784142)

    @invoice_item = InvoiceItem.new({
      id: 1,
      item_id: 263396013,
      invoice_id: 12,
      quantity: 5,
      unit_price: 700,
      created_at: '2012-03-27 14:54:09 UTC',
      updated_at: '2012-03-27 14:54:09 UTC',
      },
      invoice_item_repository = nil)
  end

  # def test_merchant_finds_items_merchant
  #will need to initialize item repo + merchant repo to test
  # end

  def test_initalize_organizes_row_value_id
    assert_equal 1, @invoice_item.id
  end

  def test_initalize_organizes_row_value_item_id
    assert_equal 263396013, @invoice_item.item_id
  end

  def test_initalize_organizes_row_value_quantity
    assert_equal 5, @invoice_item.quantity
  end

  def test_initalize_organizes_row_value_unit_price
    assert @invoice_item.unit_price == 7.00
    assert_equal BigDecimal, @invoice_item.unit_price.class
  end

  def test_initalize_organizes_row_value_created_at
    assert_equal Time.parse("2012-03-27 14:54:09 UTC"), @invoice_item.created_at
  end

  def test_initalize_organizes_row_value_updated_at
    assert_equal Time.parse("2012-03-27 14:54:09 UTC"), @invoice_item.updated_at
  end

  def test_returns_price_in_dollars_formatted_as_float
    assert_equal 7.00, @invoice_item.unit_price_per_dollars
    assert_equal Float, @invoice_item.unit_price_per_dollars.class
  end

  # def test_merchant_returns_items_merchant
  #   se = SalesEngine.from_csv({
  #           :merchants => './fixtures/merchants_fixtures.csv',
  #           :items     => './fixtures/items_fixtures.csv'
  #           })
  #   ir = se.items
  #   invoice_item = ir.find_by_id(263395237)
  #   assert_equal "NatureDots", invoice_item.merchant.name
  # end
end
