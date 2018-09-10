require 'pry'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/item'
require 'bigdecimal'

class ItemTest < Minitest::Test

  # def setup
  #
  #   @decimal = BigDecimal.new(10.99, 4)
  #   @created = Time.new(2018, 9, 7)
  #   @updated = Time.new(2018, 9, 8)
  #
  #   input = {
  #     :id => 1,
  #     :name => "Pencil",
  #     :description => "You can use it to write things",
  # ===================================
  #  This is actually feeding our program the result it's supposed to return
  #  We need our program to convert this string value into a big decimal float
  #     :unit_price => @decimal,
  # ===================================
  #     :created_at => @created,
  #     :updated_at => @updated,
  #     :merchant_id => 2
  #   }
  #
  #   @item = Item.new(input)
  # end


  def setup
    # -- First Item's information --
    #          (from csv)
    # NOTE - The description is only an except.
    # NOTE - DO NOT try to match the description value (@repo.all[0].description)
    @headers = [:id, :created_at, :merchant_id, :name, :description, :unit_price, :updated_at]
    # --- CSVParse created hash set ---
    @hash = {
              :id             => 263395237,
              :name           => "510+ RealPush Icon Set",
              :description    => "You&#39;ve got a total socialmedia iconset!", # NOTE - excerpt!
              :unit_price     => "1200",
              :merchant_id    => "12334141",
              :created_at     => "2016-01-11 09:34:06 UTC",
              :updated_at     => "2007-06-04 21:35:10 UTC"
    }
    @item = Item.new(@hash)
    @decimal = 1200.0000
    # -----------------------------------
  end


  def test_it_exists
    assert_instance_of Item, @item
  end

  def test_it_gets_attributes
    assert_equal @hash[:id], @item.id
    assert_equal @hash[:created_at], @item.created_at
    assert_equal @hash[:merchant_id], @item.merchant_id

    assert_equal @hash[:name], @item.name
    assert_equal @hash[:description], @item.description
    assert_equal @decimal, @item.unit_price
    assert_equal @hash[:updated_at], @item.updated_at
  end


end
