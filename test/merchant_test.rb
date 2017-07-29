require 'simplecov'
require 'minitest/autorun'
require 'minitest/pride'
require 'time'
require './lib/merchant'

class MerchantTest < Minitest::Test

  def setup
    @merchant = Merchant.new({:id => 5,
                             :name => "Turing School",
                             :created_at => "2010-12-10",
                             :updated_at => "2011-12-04"},
                             "MerchantRepo")
  end

  def test_it_exists_with_attributes
    assert_instance_of Merchant, @merchant
    assert_equal 5, @merchant.id
    assert_equal "Turing School", @merchant.name
    assert_instance_of Time, @merchant.created_at
    assert_instance_of Time, @merchant.updated_at
  end

end
