require 'simplecov'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/sales_analyst'
require './lib/sales_engine'

class SalesAnalystTest < Minitest::Test

  def setup
    @sales_engine  = SalesEngine.from_csv({:items    => "./data/items.csv",
                                    :merchants     => "./data/merchants.csv",
                                    :invoices      => "./data/invoices.csv"
                                    })
    @sales_analyst = SalesAnalyst.new(@sales_engine)
  end

  def test_it_exist
    assert_instance_of SalesAnalyst, @sales_analyst
  end

end
