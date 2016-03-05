 require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/invoice'
require_relative '../lib/sales_engine'

class InvoiceTest < Minitest::Test

  def setup
    # se = SalesEngine.from_csv({
    #         :merchants => './fixtures/merchants_fixtures.csv',
    #         :items     => './fixtures/items_fixtures.csv'
    #         })
    # @ir = se.items
    # @item = @ir.find_by_id(14784142)

    @invoice = Invoice.new({
      id: 1,
      costumer_id: 1,
      merchant_id: 14784142,
      status: :pending,
      created_at: '2009-02-07',
      updated_at: '2014-03-15'
      },
      invoice_repository = nil)
  end

  def test_initalize_organizes_row_value_id
    assert_equal 1, @invoice.id
  end

  def test_initalize_organizes_row_value_merchant_id
    assert_equal 14784142, @invoice.merchant_id
  end

  def test_initalize_organizes_row_value_status
    assert_equal :pending, @invoice.status
  end

  def test_initalize_organizes_row_value_created_at
    assert_equal Time.parse("2009-02-07"), @invoice.created_at
  end

  def test_initalize_organizes_row_value_updated_at
    assert_equal Time.parse("2014-03-15"), @invoice.updated_at
  end

  # def test_returns_price_in_dollars_formatted_as_float
  #   assert_equal 12.00, @item.unit_price_per_dollars
  # end

  # def test_merchant_returns_items_merchant
  #   se = SalesEngine.from_csv({
  #           :merchants => './fixtures/merchants_fixtures.csv',
  #           :items     => './fixtures/items_fixtures.csv'
  #           })
  #   ir = se.items
  #   item = ir.find_by_id(263395237)
  #   assert_equal "NatureDots", item.merchant.name
  # end
end
