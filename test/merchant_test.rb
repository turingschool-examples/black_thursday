require 'minitest/autorun'
require 'minitest/pride'
require './lib/merchant'

class MerchantTest < Minitest::Test

  attr_reader :merchant

  def setup
    @merchant = Merchant.new({:id => 1, :name => "StarCityGames"})
  end

  def test_it_exists
    assert_instance_of Merchant, merchant
  end

  def test_it_has_id
    assert_equal 1, merchant.id
  end

  def test_it_has_a_name
    assert_equal "StarCityGames", merchant.name
  end

end
