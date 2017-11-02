require './test/test_helper'
require './lib/merchant'

class MerchantTest < Minitest::Test
  attr_reader :me_1, :me_2

  def setup
    parent = mock('parent')
    @me_1 = Merchant.new({
      :id         => "12334141",
      :name       => "jejum",
      :created_at => "2007-06-25",
      :updated_at => "2015-09-09"
    }, parent)
    @me_2 = Merchant.new({
      :id         => "24537741",
      :name       => "ashton john",
      :created_at => "2007-09-10",
      :updated_at => "2015-10-11"
    }, parent)
  end

  def test_can_be_initialized_with_attributes
    assert_equal "12334141", me_1.id
    assert_equal "jejum", me_1.name
    assert_equal "2007-06-25", me_1.created_at
    assert_equal "2015-09-09", me_1.updated_at
    assert_instance_of Merchant, me_1
  end

  def test_can_be_initialized_with_other_attributes
    assert_equal "24537741", me_2.id
    assert_equal "ashton john", me_2.name
    assert_equal "2007-09-10", me_2.created_at
    assert_equal "2015-10-11", me_2.updated_at
    assert_instance_of Merchant, me_2
  end

  def test_can_use_items
    me_1.parent.stubs(:find_all_items_by_merchant_id).with(me_1.id)
    me_2.parent.stubs(:find_all_items_by_merchant_id).with(me_2.id)

    assert_nil me_1.items
    assert_nil me_2.items
  end
end
