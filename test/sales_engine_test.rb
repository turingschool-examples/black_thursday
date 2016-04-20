require './test/test_helper.rb'
class SalesEngineTest < Minitest::Test

  def test_it_creates_repos
    assert_equal MerchantRepository, @engine.merchants.class
    assert_equal ItemRepository, @engine.items.class
  end

end
