require './test/test_helper'
require './lib/merchant'

class MerchantTest < Minitest::Test
  def test_can_be_initialized_with_attributes
    me = Merchant.new({
      :id         => "12334141",
      :name       => "jejum",
      :created_at => "2007-06-25",
      :updated_at => "2015-09-09"
    })

    assert_equal "12334141", me.id
    assert_equal "jejum", me.name
    assert_equal "2007-06-25", me.created_at
    assert_equal "2015-09-09", me.updated_at
    assert_instance_of Merchant, me
  end

  def test_can_be_initialized_with_attributes
    me = Merchant.new({
      :id         => "24537741",
      :name       => "ashton john",
      :created_at => "2007-09-10",
      :updated_at => "2015-10-11"
    })

    assert_equal "24537741", me.id
    assert_equal "ashton john", me.name
    assert_equal "2007-09-10", me.created_at
    assert_equal "2015-10-11", me.updated_at
    assert_instance_of Merchant, me
  end
end
