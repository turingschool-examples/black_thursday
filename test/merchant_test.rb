require './test/test_helper'
require './test/fixtures/mock_merchant_repo'
require './lib/merchant'

# Tests merchant class
class MerchantTest < Minitest::Test
  def setup
    @merchant = Merchant.new({ id: 5, name: 'Turing School' }, 'parent')
  end

  def test_merchant_class_exists
    assert_instance_of Merchant, @merchant
  end

  def test_id_and_name
    assert_equal 5, @merchant.id
    assert_equal 'Turing School', @merchant.name
  end

  def test_other_attributes
    merchant = Merchant.new({ id: 1, name: 'Haliburton' }, 'parent')

    assert_equal 1, merchant.id
    assert_equal 'Haliburton', merchant.name
    assert_equal 'parent', merchant.parent
  end

  def test_it_asks_parent_for_items
    mock_repo = MockMerchantRepo.new
    merchant = Merchant.new({ id: 1, name: 'Haliburton' }, mock_repo)

    assert_equal 2, merchant.items.length
    merchant.items.each do |item|
      assert_instance_of MockItem, item
    end
  end
end
