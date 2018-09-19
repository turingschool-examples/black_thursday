require_relative './test_helper'

class MerchantTest < Minitest::Test
  def test_it_exists
    merchant = Merchant.new({:id => 5, :name => "Turing School", :created_at => Time.now})

    assert_instance_of Merchant, merchant
  end

  def test_it_has_attributes
    merchant = Merchant.new({:id => 5, :name => "Turing School", :created_at => "2016-01-11 12:29:33 UTC"})

    assert_equal 5, merchant.id
    assert_equal "Turing School", merchant.name
    assert_equal Time.parse("2016-01-11 12:29:33 UTC"), merchant.time
  end

end
