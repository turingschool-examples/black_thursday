require_relative "test_helper"

class SalesEngineTest < Minitest::Test

  def test_it_exist
    se = SalesEngine.new
    assert_instance_of SalesEngine, se
  end

  def test_imports_from_csv
    se = SalesEngine.from_csv({
    :items     => "./data/items.csv",
    :merchants => "./data/merchants.csv",
    })

    binding.pry
    assert_equal ItemRepository, se.items
  end

end
