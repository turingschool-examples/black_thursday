require_relative 'test_helper'
require './lib/sales_engine'


class SalesEngineTest < MiniTest::Test

  def setup
    @sales_engine = SalesEngine.new
  end

  def test_it_exist
    assert_instance_of SalesEngine, @sales_engine
  end



  # def test_it_has_an_item_repo
  #   assert @sales_engine.item_repository
  # end


end
