require 'minitest/autorun'
require 'minitest/pride'
require 'simplecov'
require 'pry'
require 'csv'
require './lib/merchant.rb'

class MerchantTest < Minitest::Test

  def test_class_exists
    assert_instance_of Merchant, Merchant.new({id:"12334105",  name:"Shopin1901", created_at:"2010-12-10", updated_at:"2011-12-04"})
  end

  def test_id
    m = Merchant.new({id:"12334105",  name:"Shopin1901", created_at:"2010-12-10", updated_at:"2011-12-04"})
    assert_equal 12334105, m.id 
  end

  def test_name
    m = Merchant.new({id:"12334105",  name:"Shopin1901", created_at:"2010-12-10", updated_at:"2011-12-04"})
    assert_equal "Shopin1901", m.name
  end

end
