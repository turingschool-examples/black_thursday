require_relative 'test_helper'
require './lib/standard_deviation'
require './lib/analyst_helper'
require './lib/analyst_operations'

class AnalystOperationsTest < Minitest::Test

  def setup
      @se = SalesEngine.from_csv({
      :items => "./fixtures/items_small_list.csv",
      :invoices => "./fixtures/invoices_small_list.csv",
      :merchants => "./fixtures/merchant_small_list.csv",
      :invoice_items => "./fixtures/invoice_item_small_list.csv",
      :transactions => "./fixtures/transactions_small_list.csv",
      :customers => "./fixtures/customers_small_list.csv"
    })
    @sa = SalesAnalyst.new(@se)
  end

    def test_average_method_works_for_all_cases
      assert_equal 3.0, @sa.average([2,3,4])
      assert_equal 2.0, @sa.average([2])
      assert_equal "NaN", @sa.average([]).to_s
    end

  def test_status_average_operator_returns_correct_value
    assert_equal "71.42857142857143", @sa.status_average_operator(:pending)
  end

  def test_status_average_formatter_properly_formats
    assert_equal "42.857142857142854", @sa.status_average_formatter([1,2,3])
  end

  def test_single_operator_formats_single
    assert_equal 1.0, @sa.single_operator([1])
  end

  def test_average_average_operator_does_the_legwork
    assert_equal 2.04, @sa.average_average_operator.to_f
  end

end