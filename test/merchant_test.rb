require_relative 'test_helper.rb'
require_relative '../lib/merchant'

class MerchantTest < Minitest::Test
  def test_it_exists
    m = Merchant.new({:id => 5}, "engine")

    assert_instance_of Merchant, m
  end

  def test_it_knows_id
    m = Merchant.new({:id => 5}, "engine")
    assert_equal 5, m.id
  end

  def test_it_knows_name
    m = Merchant.new({:name => "Turing"}, "engine")
    assert_equal "Turing", m.name
  end

end
