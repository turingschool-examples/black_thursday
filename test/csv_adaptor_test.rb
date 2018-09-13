require 'simplecov'
SimpleCov.start
require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/sales_engine'
require_relative '../lib/csv_adaptor'

class CsvAdaptorTest < Minitest::Test

  def test_it_exists
    data_file = "./data/merchants.csv"
    a = CsvAdaptor.new

    assert_instance_of CsvAdaptor, a
  end

  def test_load_merchants
    a = CsvAdaptor.new
    data_file = "./data/merchants.csv"

    assert_instance_of Array, a.load_merchants(data_file)
  end

end
