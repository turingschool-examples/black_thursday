require 'minitest/autorun'
require 'minitest/pride'
require './lib/merchant'

class MerchantTest < Minitest::Test

  def test_merchant_exists
    m = Merchant.new({:id => 5, :name => "Turing School"})
    assert_instance_of Merchant, m
  end

  def test_check_that_merchant_has_attributes
    m = Merchant.new({:id => 5, :name => "Turing School",
      :created_at => "2012-09-10", :updated_at => "2012-10-10"})
    assert_equal 5, m.id
    assert_equal "Turing School", m.name
    assert_equal "2012-09-10", m.created_at
    assert_equal "2012-10-10", m.updated_at
  end

end
