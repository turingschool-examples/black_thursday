require_relative "test_helper.rb"
require_relative "../lib/sales_engine"

class SalesEngineTest < Minitest::Test
  def setup
    @content = {
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv",
    }
    @sales_engine = SalesEngine.from_csv(@content)
  end

  def test_it_exists
    assert_instance_of SalesEngine, @sales_engine
  end

  def test_it_has_attributes
    assert_equal @content, @sales_engine.content
  end

  def test_can_get_data_from_csv
    assert_equal @content, @sales_engine.from_csv(@content)
  end


end
