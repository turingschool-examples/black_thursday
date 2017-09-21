require "./test/test_helper"
require "./lib/sales_engine"
require "./lib/sales_analyst"
require "./lib/item_repository"
require "./lib/merchant_repository"
require "./lib/merchant"
require "./lib/item"


class TestTopDaysByInvoiceCount < Minitest::Test

  attr_reader :sa

  def setup
    csv_hash = {
      :items     => "./test/test_fixtures/items_medium.csv",
      :merchants => "./test/test_fixtures/merchants_medium.csv",
      :invoices => ".//test/test_fixtures/invoices_medium.csv",
      :invoice_items => "./data/invoice_items.csv",
      :transactions => "./test/test_fixtures/transactions_medium.csv",
      :customers => "./test/test_fixtures/customers_medium.csv"
    }
    sales_engine = SalesEngine.from_csv(csv_hash)
    @sa = SalesAnalyst.new(sales_engine)
  end

  def test_it_exists
    assert_instance_of SalesAnalyst, sa
  end

  def test_it_gets_date_from_invoices
    assert_equal "2009,2,7", sa.date_from_invoices[0]
  end

  def test_it_makes_hash_of_date_and_invoice_id
    assert_equal [1, 6], sa.invoice_id_with_date.first
  end

  def test_it_finds_average_invoices_per_day
    assert_equal 343, sa.average_invoices_per_day
  end

  def test_it_makes_invoices_per_day_hash
    assert_equal [6, 348], sa.invoices_per_day.first
  end

  def test_it_makes_the_numerator
    assert_equal 1897, sa.top_day_numerator
  end

  def test_it_returns_denominator
    assert_equal 6, sa.top_day_denominator
  end

  def test_it_returns_top_day_standard_deviation
    assert_equal 17.776388834631177, sa.top_day_standard_deviation
  end

  def test_it_finds_top_days
    assert_equal [3], sa.find_top_days
  end

  def convert_numbers_to_weekdays
    assert_equal ["Wednesday"], sa.convert_numbers_to_weekdays
  end

  def test_it_find_top_days_by_invoice_count
    assert_equal ["Wednesday"], sa.top_days_by_invoice_count
  end

end
