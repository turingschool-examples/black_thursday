require './lib/items'
require './lib/item_repository'
require './lib/sales_engine'
require_relative 'test_helper'
require 'minitest/pride'

class ItemTest < Minitest::Test

def test_item_has_proper_attributes
    se = SalesEngine.from_csv({
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv"})
    ir = se.items
  assert_equal "510+ RealPush Icon Set", ir.all[0].name
  assert_equal "Minty Green Knit Crochet Infinity Scarf", ir.all.last.name
  assert_equal 263395237, ir.all[0].id
  assert_equal 263567474, ir.all.last.id
  assert_equal "Glitter scrabble frames \n\nAny colour glitter \nAny wording\n\nAvailable colour scrabble tiles\nPink\nBlue\nBlack\nWooden", ir.all[1].description
  assert_equal "Adidas Penarol mit Schraubstollen inkl. der Originalverpackung. Hergestellt ab dem Jahr 1987.", ir.all[100].description
  assert_equal 12, ir.all[0].unit_price.to_i
  assert_equal 38, ir.all.last.unit_price.to_i
  assert_equal "2016-01-11 09:34:06 UTC", ir.all[0].created_at.to_s
  assert_equal "2016-01-11 20:59:20 UTC", ir.all.last.created_at.to_s
  assert_equal "2007-06-04 21:35:10 UTC", ir.all[0].updated_at.to_s
  assert_equal "2009-12-09 12:08:04 UTC", ir.all.last.updated_at.to_s
  assert_equal 12334141, ir.all[0].merchant_id
  assert_equal 12334871, ir.all.last.merchant_id
  # binding.pry
end

def test_items_know_merchants
  se = SalesEngine.from_csv({
    :items     => "./data/items.csv",
    :merchants => "./data/merchants.csv"})
  ir = se.items
  refute ir.all[0].merchant.nil?
  refute ir.all[0].merchant.eql?(ir.all[1].merchant)
end

end
