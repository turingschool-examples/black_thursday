# frozen_string_literalL true

require 'timecop'
require './test/test_helper'
require './lib/merchant'
require './lib/sales_engine'

# merchant test
class MerchantTest < Minitest::Test
  def setup
    Timecop.freeze
  end

  def teardown
    Timecop.return
  end

  def test_merchant_exists
    merchant = Merchant.new({
      id:         5,
      name:       'Turing School',
      created_at: 11/11/11,
      updated_at: 12/21/12,
    }, 'parent')

    assert_instance_of Merchant, merchant
  end

  def test_mechant_collects_id_and_name
    merchant = Merchant.new({
      id:         5,
      name:       'Turing School',
      created_at: 11/11/11,
      updated_at: 12/21/12,
    }, 'parent')

    assert_equal 5, merchant.id
    assert_equal 'Turing School', merchant.name
    assert_equal 11/11/11, merchant.created_at
    assert_equal 12/21/12, merchant.updated_at
  end

  def test_change_attributes
    merchant = Merchant.new({
      id:         5,
      name:       'Turing School',
      created_at: 11/11/11,
      updated_at: 12/21/12,
    }, 'parent')

    assert_equal 'Turing School', merchant.name

    merchant.change_name('New Name')

    assert_equal 'New Name', merchant.name

    assert_equal 12/21/12, merchant.updated_at

    merchant.change_updated_at

    assert_equal Time.now, merchant.updated_at
  end
end
