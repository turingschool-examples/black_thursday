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
      invoice_items: './data/invoice_items.csv'
    )
    @s = SalesAnalyst.new(@se)
  end

  def test_it_exists
    assert_instance_of SalesAnalyst, @s
  end

  def test_it_gives_average_items_per_merchant
    expected = 2.88
    actual = BigDecimal(@s.average_items_per_merchant, 3)

    assert_equal expected, actual
  end

  def test_it_can_calculate_standard_deviation
    expected = 3.26
    actual = BigDecimal(@s.average_items_per_merchant_standard_deviation, 3)

    assert_equal expected, actual
  end

  # Need to create mocks for testing
  def test_it_can_calculate_merchants_with_high_item_counts
    actual = @s.merchants_with_high_item_count.first.name
    expected = 'Keckenbauer'
    assert_equal expected, actual
  end

  def test_it_finds_max_price
    expected = 99999
    actual = @s.find_max_price

    assert_equal expected, actual
  end

  def test_it_returns_correct_standard_deviation_for_price
    expected = 2902.69
    actual = @s.standard_deviation_of_item_price.round(2)

    assert_equal expected, actual
  end

  def test_it_can_find_the_golden_items
    expected = 5
    actual = @s.golden_items.length

    assert_equal expected, actual
  end

  def test_it_can_find_one_time_buyers
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

    assert_equal 3, expected.length
  end

  def test_it_can_return_all_transactions
    expected = @s.transactions

    assert_equal 13, expected.length
  end

  def test_it_can_return_successful_transactions
    expected = @s.successful_transactions

    assert_equal 11, expected.length
  end

  def test_it_can_return_total_revenue_by_date
    skip
    date = Time.parse("2012-03-27")
    assert_equal 3471.59, @s.total_revenue_by_date(date)
  end
#   def total_revenue_by_date(date)
#     date1 = date.to_date
#     successful(by_date(@sales_engine.transations.all, date1))
#     transactions = @sales_engine.transactions.all
#     dated = transactions.find_all do |transaction|
#       transaction.created_at.to_date == date1
#     end
#     successes = dated.find_all { |transaction| transaction.result == 'success' }
#     binding.pry
#   end
#   def by_date(list, date)
#     list.keep_if {|l| date == l.created_at.to_date}
#   end
#    def successful(list)
#      list.keep_if { |l| l.result == "success"}
#    end
# Justine end work on iteration 4
end
