require 'minitest/autorun'
require 'minitest/pride'
require 'pry'
require_relative "../lib/sales_engine"

class SalesEngineTest < Minitest::Test


  def setup
    se = SalesEngine.new
    @result = se.from_csv({:items     => "./data/items.csv",
                          :merchants => "./data/merchants.csv"})
  end

#test:parameter acceptance
  def test_from_csv_has_array_as_output
    assert_equal Hash, @result.class
  end

#test:parsing/return values
  def test_can_get_item_names_and_merchant_names
  #test to verify item name -> result[:items][:names] = [array of names]
  #test to verify merchant name
  item_array = @result[:items]
  merchant_array = @result[:merchants] 

  assert_equal [], item_array
  assert_equal [], merchant_array
  end

  def test_from_csv_outputs_item_ids_and_merchant_ids
  #test to verify item id
  #test to verify merchant id
  end






end
