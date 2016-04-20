require 'simplecov'
SimpleCov.start
require 'minitest/autorun'
require 'minitest/pride'
require './lib/item.rb'

class ItemTest < Minitest::Test

  def setup
    item_data = ['263395237','510+ RealPush Icon Set',
     'this is a test description','1200','12334141',
     '2016-01-11 09:34:06 UTC','2007-06-04 21:35:10 UTC']
    @item = Item.new(item_data)
   end

   def test_id
     assert_equal 263395237, @item.id
   end

   def test_name
     assert_equal '510+ RealPush Icon Set', @item.name
   end

   def test_description
     result = 'this is a test description'
     assert_equal result, @item.description
   end

   def test_unit_price_is_Big_Decimal
     assert_equal BigDecimal, @item.unit_price.class
   end

   def test_unit_price_to_dollars
     assert_equal 12.00, @item.unit_price_to_dollars
   end

   def test_created_at
     assert_equal Time, @item.created_at.class
   end

   def test_updated_at
     assert_equal Time, @item.updated_at.class
   end

   def test_merchant_id
     assert_equal 12334141, @item.merchant_id
   end
end
