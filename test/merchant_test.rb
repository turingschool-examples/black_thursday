require './test/test_helper'

class MerchantTest < Minitest::Test
  def setup
    args = {id: 1, name: "Kasey's Pizza"}
    #parent = mock('parent')
    @merchant = Merchant.new(args[:id], args[:name]) #parent)
  end

  def test_it_exists
    assert_instance_of Merchant, @merchant
  end

  def test_it_has_attributes
    assert_equal 1, @merchant.id
    assert_equal "Kasey's Pizza", @merchant.name
  end
end
