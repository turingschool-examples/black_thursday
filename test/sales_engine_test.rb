require 'simplecov'
SimpleCov.start

require 'minitest/pride'
require 'minitest/autorun'
require_relative '../lib/merchant'
require_relative '../lib/merchant_repository'

class SalesEngineTest < Minitest::Test

  def test_it_exists
    assert_instance_of SalesEngine, @salesengine
  end

  def test_we_can_read_a_csv_file
    se = SalesEngine.from_csv({merchants: './data/merchants.csv'})

  end

end
