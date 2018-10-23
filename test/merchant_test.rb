require_relative 'test_helper.rb'
require_relative '../lib/merchant'
require 'pry'


class MerchantTest < Minitest::Test
  def setup
    @merchant = Merchant.new({:id => 5, :name => "Nixon"})
  end

  def test_it_exists
    assert_instance_of Merchant, @merchant
  end

  def test_it_has_an_id
    assert_equal 5, @merchant.id
  end

  def test_it_has_an_name
    assert_equal "Nixon", @merchant.name
  end
end
