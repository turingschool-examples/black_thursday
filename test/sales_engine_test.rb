require_relative "test_helper.rb"
require_relative "../lib/sales_engine"

class SalesEngineTest < Minitest::Test
  def setup
    @csv_hash = {
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv",
    }
    @sales_engine = SalesEngine.from_csv(@csv_hash)
  end

  def test_it_exists
    assert_instance_of SalesEngine, @sales_engine
  end

  # def test_it_has_attributes
  #   skip
  #   assert_equal , @sales_engine.
  # end

  def test_it_can_get_data_from_csv
    assert_equal @csv_hash, @sales_engine
  end


end
