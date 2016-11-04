require_relative 'test_helper'
require './lib/sales_engine'

class SalesEngineTest < Minitest::Test

  def test_it_exists
    assert SalesEngine.new({
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv"
      })
  end

  def test_sales_engine_can_load_csv_files
    # se = SalesEngine.new
    se = SalesEngine.from_csv({
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv"
      })
      # binding.pry
    assert_equal CSV::Table, se.raw_data[:items].class
    assert_equal CSV::Table, se.raw_data[:merchants].class
  end

  def test_it_can_talk_to_item_repo
    se = SalesEngine.from_csv({
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv"
      })
      
    
    assert_equal Array, se.items.all.class
  end
end