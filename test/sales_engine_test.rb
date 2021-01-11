require 'minitest/autorun'
require 'minitest/pride'
require './lib/sales_engine'
require './lib/sales_analyst'
require 'csv'

class SalesEngineTest < Minitest::Test
  def setup
    @merchant_path = './data/merchants.csv'
    @item_path = './data/items.csv'
    @invoice_path = './data/invoices.csv'
    @locations = { items: @item_path,
                  merchants: @merchant_path,
                  invoices: @invoice_path
                }

    @sales_engine = SalesEngine.from_csv(@locations)
  end

  def test_it_exists_and_has_attributes
    skip
    assert_instance_of SalesEngine, @sales_engine
  end

  def test_it_creates_sales_analyst
    skip
    assert_instance_of SalesAnalyst, @sales_engine.analyst
  end

  def test_returns_total_invoices
    skip
    assert_equal 4985, @sales_engine.total_invoices
  end

  def test_returns_per_merchant_invoice_count_hash
    skip
    assert_equal 475, @sales_engine.per_merchant_invoice_count_hash.length
  end

  def test_returns_invoices_per_day
    days = { "Monday" =>    696,
             "Tuesday" =>   692,
             "Wednesday" => 741,
             "Thursday" =>  718,
             "Friday" =>    701,
             "Saturday" =>  729,
             "Sunday" =>    708}

    assert_equal days, @sales_engine.invoices_per_day
  end

  def test_invoices_per_status
    # skip
    status = {pending:  1473,
              shipped:  2839,
              returned: 673}

    assert_equal status, @sales_engine.invoices_per_status
  end
end
