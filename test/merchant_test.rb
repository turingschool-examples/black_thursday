require_relative 'test_helper'

require './lib/merchant'


class MerchantTest < Minitest::Test

  def setup
    # CSV: 12334105,Shopin1901,2010-12-10,2011-12-04
    input = {:id => "12334105", :name => "Shopin1901"}
    @merchant = Merchant.new(input)
  end

  def test_it_exists
    assert_instance_of Merchant, @merchant
  end

  def test_it_has_attributes
    assert_equal 12334105, @merchant.id
    assert_equal "Shopin1901", @merchant.name
  end


end
