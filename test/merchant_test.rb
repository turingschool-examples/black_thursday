require_relative 'test_helper'
require_relative '../lib/merchant'

class MerchantTest < Minitest::Test
  def test_it_exists
    merchant = Merchant.new({:id => "12334113", :name => "MiniatureBikez",  :created_at => "2010-03-30", :updated_at => "2013-01-21"})

    assert_instance_of Merchant, merchant
  end

  def test_it_returns_correct_id
    merchant = Merchant.new({:id => "12334113", :name => "MiniatureBikez",  :created_at => "2010-03-30", :updated_at => "2013-01-21"})

    assert_equal 12334113, merchant.id
  end

  def test_it_returns_correct_name
    merchant = Merchant.new({:id => "12334113", :name => "MiniatureBikez",  :created_at => "2010-03-30", :updated_at => "2013-01-21"})

    assert_equal "MiniatureBikez", merchant.name
  end

  def test_time_returns_time_exists
    merchant = Merchant.new({:id => "12334113", :name => "MiniatureBikez",  :created_at => "2010-03-30", :updated_at => "2013-01-21"})

    assert_instance_of Time, merchant.created_at
    assert_instance_of Time, merchant.updated_at
  end
end
