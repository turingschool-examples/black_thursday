require './test/test_helper'
require './lib/merchant'
require 'pry'
class MerchantTest < Minitest::Test
  def test_merchant_exists
    merchant = Merchant.new({
      id: 5,
      name: 'Turing School',
      created_at: 11/11/11,
      updated_at: 12/21/12,
    }, 'parent')

    assert_instance_of Merchant, merchant
  end

  def test_mechant_collects_id_and_name
    merchant = Merchant.new({
      id: 5,
      name: 'Turing School',
      created_at: 11/11/11,
      updated_at: 12/21/12,
    }, 'parent')

    assert_equal 5, merchant.id
    assert_equal 'Turing School', merchant.name
    assert_equal 11/11/11, merchant.created_at
    assert_equal 12/21/12, merchant.updated_at
  end
end
