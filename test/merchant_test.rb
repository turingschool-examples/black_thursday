require_relative './test_helper'
require './lib/merchant'
require 'mocha/minitest'


class MerchantTest < Minitest::Test
  def test_it_exists_and_has_attributes
    repo = mock
    merchant = Merchant.new({:id => 5, 
                            :name => "Turing School",
                            :created_at  => Time.now,
                            :updated_at  => Time.now
                            }, repo)
    
    merchant_test_created_at = merchant.created_at.strftime("%d/%m/%Y")
    merchant_test_updated_at = merchant.updated_at.strftime("%d/%m/%Y")
    assert_instance_of Merchant, merchant
    assert_equal 5, merchant.id
    assert_equal "Turing School", merchant.name
    assert_equal Time.now.strftime("%d/%m/%Y"), merchant_test_created_at
    assert_equal Time.now.strftime("%d/%m/%Y"), merchant_test_updated_at
    assert_equal repo, merchant.repository 
  end
end
