require 'minitest/autorun'
require 'minitest/emoji'
require './lib/sales_engine.rb'

class SalesEngineTest < Minitest::Test

  def test_it_exists
    se = SalesEngine.from_csv({:items => 1,
                               :merchants => 1})
    # se will return an instance of SalesEngine
    assert_instance_of SalesEngine, se
    
  end


end