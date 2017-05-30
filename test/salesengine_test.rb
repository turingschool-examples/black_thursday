require "minitest/autorun"
require "minitest/emoji"
require "./lib/salesengine"
class SalesEngineTest < Minitest::Test
  def test_it_exists
    se = SalesEngine.new

    assert_instance_of SalesEngine, se
  end

  def test_can_access_items_instance_variable
    se = SalesEngine.new

    assert_nil se.items
  end

  def test_can_acccess_merchant_instance_variable
    se = SalesEngine.new

    assert_nil se.merchants
  end

  def test_can_access_from_csv
    skip
    se = SalesEngine.from_csv({"items" => "test1", "merchants"=> "test2"})

    assert_equal "test1", se.items
    assert_equal "test2", se.merchants
  end

end
