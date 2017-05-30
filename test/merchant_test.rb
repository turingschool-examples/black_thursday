require 'minitest/autorun'
require 'minitest/pride'
require './lib/merchant'

class MerchantTest < Minitest::Test

  attr_reader :merchant, :merchant2

  def setup
    @merchant = Merchant.new({:id => 1, :name => "StarCityGames"})
    @merchant2 = Merchant.new({:id => 2, :name => "Amazong"})
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

  def test_it_can_have_different_id
    assert_equal 2, merchant2.id
  end

  def test_it_can_have_different_name
    assert_equal "Amazong", merchant2.name
  end

end
