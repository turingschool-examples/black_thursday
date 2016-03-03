require 'minitest/autorun'
require 'minitest/pride'
require 'csv'
require_relative '../lib/sales_engine'

class SalesEngineTest < Minitest::Test

  def test_from_csv_accepts_hash
    sales_engine = SalesEngine.new.from_csv({:merchants => './fixtures/merchants_fixture.csv'})
    expected = ({merchants: {:id => nil }})
    assert_equal expected, sales_engine
  end

end
