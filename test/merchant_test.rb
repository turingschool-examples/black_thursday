require './test/test_helper'
require './lib/merchant'
require 'pry'
class MerchantTest < Minitest::Test
  def test_merchant_exists
    m = Merchant.new(:id => 5, :name => 'Turing School',\
                     :created_at => 11/11/11, :updated_at => 12/21/12)

    assert_instance_of Merchant, m
  end

  def test_mechant_collects_id_and_name
    m = Merchant.new(:id => 5, :name => 'Turing School',\
                     :created_at => 11/11/11, :updated_at => 12/21/12)
                     
    assert_equal 5, m.id
    assert_equal 'Turing School', m.name
    assert_equal 11/11/11, m.created_at
    assert_equal 12/21/12, m.updated_at
  end
end
