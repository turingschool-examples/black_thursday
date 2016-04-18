require "minitest/autorun"

class SalesEngineTest < Minitest::Test


  def test_it_loads_items_csv
    se = SalesEngine.new
    assert se.items.include?("id,name,description")
  end

  def test_it_loads_merchants_csv
    se = SalesEngine.new
    assert se.merchants.include?("id,name,created_at,updated_at")
  end
end
