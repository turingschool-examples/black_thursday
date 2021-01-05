require 'minitest/autorun'
require 'minitest/pride'
require './lib/merchant'
class MerchantTest < Minitest::Test
  def setup
    args = {id: 1, name: "Kasey's Pizza"}
    @merchant = Merchant.new(args[:id], args[:name])
  end

  def test_it_exists
  assert_instance_of Merchant, @merchant
  end

  def test_it_has_attributes
    assert_equal 1, @merchant.id
    assert_equal "Kasey's Pizza", @merchant.name

  end
  def test_it_can_have_different_attributes
  end
end
