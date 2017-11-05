require_relative 'test_helper'
require_relative '../lib/merchant'
require_relative '../lib/sales_engine'

class MerchantTest < Minitest::Test
  def setup
    merchant = ({:id => "12334113", :name => "MiniatureBikez",  :created_at => "2010-03-30", :updated_at => "2013-01-21"})
    Merchant.new(merchant, [])
  end

  def test_it_exists
    assert_instance_of Merchant, setup
  end

  def test_it_returns_correct_id
    assert_equal 12334113, setup.id
  end

  def test_it_returns_correct_name
    assert_equal "MiniatureBikez", setup.name
  end

  def test_time_returns_time_exists
    assert_instance_of Time, setup.created_at
    assert_instance_of Time, setup.updated_at
  end
end
