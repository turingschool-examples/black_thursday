require './test/test_helper'

class SalesAnalysisTest < Minitest::Test

  def test_it_exists
    analysis = SalesAnalysis.new(@engine)
    assert_equal SalesAnalysis, analysis.class
  end

  def test_it_has_sales_engine
    analysis = SalesAnalysis.new(@engine)
    assert_equal SalesEngine, analysis.engine.class
  end

  def test_average_items_per_merchant
    analysis = SalesAnalysis.new(@engine)
    assert_equal 1.4, analysis.average_items_per_merchant
  end

  def test_average_items_per_merchant_standard_deviation
    analysis = SalesAnalysis.new(@engine)
    assert_equal 0.8, analysis.average_items_per_merchant_standard_deviation
  end
end
