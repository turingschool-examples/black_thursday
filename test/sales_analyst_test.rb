# frozen_string_literal: true

require 'simplecov'
SimpleCov.start
require 'bigdecimal'
require 'minitest'
require 'minitest/emoji'
require 'minitest/autorun'
require './lib/sales_engine.rb'
require './lib/sales_analyst.rb'
require 'pry'

class SalesAnalystTest < MiniTest::Test
  def setup
    @se = SalesEngine.from_csv(
      items:      './data/items.csv',
      merchants:  './data/merchants.csv',
      invoices:   './data/invoices.csv',
      customers:  './data/customers.csv',
      transactions: './fixtures/transactions_test.csv',
      invoice_items: './fixtures/invoice_items_test.csv'
    )
    @s = SalesAnalyst.new(@se)
  end

  def test_it_exists
    skip
    assert_instance_of SalesAnalyst, @s
  end

  def test_it_gives_average_items_per_merchant
    skip
    expected = 2.88
    actual = BigDecimal(@s.average_items_per_merchant, 3)

    assert_equal expected, actual
  end

  def test_it_can_calculate_standard_deviation
    expected = 3.26
    actual = BigDecimal(@s.average_items_per_merchant_standard_deviation, 3)

    assert_equal expected, actual
  end

  def test_it_returns_a_list_of_items_per_merchant
    expected = 25
    actual = @s.list_of_number_of_items_per_merchant[4]

    assert_equal expected, actual
  end


  # Need to create mocks for testing
  def test_it_can_calculate_merchants_with_high_item_counts
    expected = 'Keckenbauer'
    actual = @s.merchants_with_high_item_count.first.name
    assert_equal expected, actual
  end

  def test_it_finds_max_price
    skip
    expected = 99999
    actual = @s.find_max_price

    assert_equal expected, actual
  end

  def test_it_returns_correct_standard_deviation_for_price
    expected = 2901.63
    actual = @s.standard_deviation_of_item_price.round(2)

    assert_equal expected, actual
  end

  def test_it_can_find_the_golden_items
    skip
    expected = 5
    actual = @s.golden_items.length

    assert_equal expected, actual
  end

  def test_it_can_find_one_time_buyers
    skip
    expected = 5
    actual = @s.one_time_buyers.length

    assert_equal expected, actual
  end

  def test_it_can_return_paid_in_full_invoice
    expected = false
    actual = @s.invoice_paid_in_full?(16)

    assert_equal expected, actual
  end

  def test_it_can_find_the_invoice_total
    expected = 3489.56
    actual = @s.invoice_total(1).to_f.round(2)

    assert_equal expected, actual
  end
# Justine start work on iteration 4
  def test_it_can_find_transactions_by_date
    date = Time.parse("2012-03-27")
    expected = @s.transactions_by_date(date)


  def test_invoices_can_return_successful_transactions
    expected = true
    invoice = @se.invoices.find_by_id(14)
    actual = invoice.is_paid_in_full?

    assert_equal expected, actual
  end

  def test_invoice_items_can_be_grouped_by_id_and_item_quantity
    skip
    expected = ''
    actual = @se.invoice_items.group_invoice_items_by_number_of_items_and_invoice_id
    
    assert_equal 3, expected.length
  end

  def test_it_can_return_successful_transactions
    expected = @s.successful_transactions

    assert_equal 11, expected.length
  end

  def test_it_can_return_successful_invoices_by_date
    expected = @s.successful_invoices_by_date(Time.parse("2012-03-27"))

    assert_equal Array, expected.class
    assert_equal 2, expected.length
  end

  def test_it_can_get_unique_ids_of_successful_transactions_on_date
    dated_success = @s.successful_invoices_by_date(Time.parse("2012-03-27"))
    expected = @s.ids_of_successful_invoices_by_date(dated_success)

    assert_equal 1, expected.length
  end

  def test_it_can_pull_invoice_items_of_ids_for_successful_dated
    dated_success = @s.successful_invoices_by_date(Time.parse("2012-03-27"))
    ids = @s.ids_of_successful_invoices_by_date(dated_success)
    invoice_items = @s.successful_dated_invoice_ids(ids)
    expected = invoice_items.flatten

    assert_instance_of InvoiceItem, expected[0]
    assert_equal 2, expected.length
  end

  def test_it_can_multiply_quantity_and_unit_price
    dated_success = @s.successful_invoices_by_date(Time.parse("2012-03-27"))
    ids = @s.ids_of_successful_invoices_by_date(dated_success)
    invoice_items = @s.successful_dated_invoice_ids(ids)
    result = invoice_items.flatten

    assert_equal 3471.59, @s.quantity_by_unit_price(result)
  end

  def test_it_can_return_total_revenue_by_date
    date = Time.parse("2012-03-27")

    assert_equal 3471.59, @s.total_revenue_by_date(date)
  end
# Justine end work on iteration 4
end
