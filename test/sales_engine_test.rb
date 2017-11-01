require_relative "test_helper"

class SalesEngineTest < Minitest::Test

  def test_it_exists
    se = SalesEngine.new
    assert_instance_of SalesEngine, se
  end

  def test_imports_from_csv
    se = SalesEngine.from_csv({
    :items     => "./data/items.csv",
    :merchants => "./data/merchants.csv",
    })

    assert_instance_of ItemRepository, se.items
    assert_instance_of MerchantRepository, se.merchants
  end

end
