require 'simplecov'
SimpleCov.start
require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/sales_engine'
require_relative '../lib/csv_adaptor'

class SalesEngineTest < Minitest::Test

  def test_it_exists
    se = SalesEngine.new

    assert_instance_of SalesEngine, se
  end

end
