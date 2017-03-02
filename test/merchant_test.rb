require './test/test_helper'

class MerchantTest < Minitest::Test
  attr_reader :merchant

  def setup
    @merchant = Merchant.new({
      :id          => 602397854,
      :name        => "Burger King",
      :created_at  => Time.now,
      :updated_at  => Time.now
      })
  end

  def test_it_has_an_id
    assert_equal 602397854, merchant.id
  end

  def test_it_has_a_name
    assert_equal "Burger King", merchant.name
  end

  def test_it_has_a_created_at
    assert_instance_of Time, merchant.created_at
  end

  def test_it_has_a_updated_at
    assert_instance_of Time, merchant.updated_at
  end
  
end
