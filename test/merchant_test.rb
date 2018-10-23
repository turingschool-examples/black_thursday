require_relative 'test_helper.rb'
require 'pry'


class MerchantTest < Minitest::Test
  def setup
    @merchant = Merchant.new({:id => 5, :name => "Nixon"})
  end

  def test_it_exists
    assert_instance_of Merchant, @merchant
  end


end
