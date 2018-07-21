require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/item.rb'
require 'bigdecimal' 
require 'time'
require 'pry' 

class ItemTest < Minitest::Test 
  def test_it_exists
    i = Item.new({:id => 1, :name => "Pencil", :description => "You can use it to write things", :unit_price => BigDecimal.new(10.99,4), :created_at => Time.now, :updated_at => Time.now, :merchant_id => 2})
    
    assert_instance_of Item, i 
  end 
  
  def test_it_has_attributes
    i = Item.new({:id => 1, :name => "Pencil", :description => "You can use it to write things", :unit_price => BigDecimal.new(10.99,4), :created_at => Time.now, :updated_at => Time.now, :merchant_id => 2})
    
    assert_equal 1, i.id
    assert_equal "Pencil", i.name
    assert_equal "You can use it to write things", i.description
    assert_equal BigDecimal.new(10.99,4), i.unit_price
    assert_equal Time, i.created_at.class
    assert_equal Time, i.updated_at.class
    assert_equal 2, i.merchant_id
  end 
    
  def test_it_gives_price_in_dollars_as_float
    i = Item.new({:id => 1, :name => "Pencil", :description => "You can use it to write things", :unit_price => BigDecimal.new(10.99,4), :created_at => Time.now, :updated_at => Time.now, :merchant_id => 2})
  
    assert_equal "$10.99", "$#{i.unit_price.to_f}"
  end
  
end 