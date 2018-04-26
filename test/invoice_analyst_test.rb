# frozen_string_literal: true

require_relative 'test_helper'
require_relative '../lib/sales_analyst'
require 'pry'

class InvoiceAnalystTest < Minitest::Test
  def setup
    item_path = './test/fixture_data/item_repo_fixture.csv'
    merchant_path = './test/fixture_data/merchant_repo_2.csv'
    invoice_path = './test/fixture_data/invoice_1.csv'
    path = { items: item_path, merchants: merchant_path,
             invoices: invoice_path }
    sales_engine = SalesEngine.from_csv(path)
    @sales_analyst = sales_engine.analyst
  end

  def test_average_invoices_per_merchant
    assert_equal 10.43, @sales_analyst.average_invoices_per_merchant
  end

  def test_it_can_find_the_std_per_deviation
    actual = @sales_analyst.average_invoices_per_merchant_standard_deviation
    assert_equal 3.98, actual
  end

  def test_it_can_find_the_top_merchants
    assert_instance_of Array, @sales_analyst.top_merchants_by_invoice_count
    assert_equal 12_334_123, @sales_analyst.top_merchants_by_invoice_count[0].id
  end

  def test_it_can_find_the_lowest_perfomers
    assert_instance_of Array, @sales_analyst.bottom_merchants_by_invoice_count
    actual = @sales_analyst.bottom_merchants_by_invoice_count[0].id
    assert_equal 12_334_115, actual
  end

  def test_top_days_by_invoice_count
    assert_equal 1, @sales_analyst.top_days_by_invoice_count.length
    assert_equal "Friday", @sales_analyst.top_days_by_invoice_count.first
    assert_instance_of String, @sales_analyst.top_days_by_invoice_count.first
  end

  def test_invoice_status
    assert_equal 28.86, @sales_analyst.invoice_status(:pending)
    assert_equal 59.7, @sales_analyst.invoice_status(:shipped)
    assert_equal 11.44, @sales_analyst.invoice_status(:returned)
  end
end
