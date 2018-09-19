require_relative 'test_helper'

require './lib/item'
require 'bigdecimal'
require 'time'

class ItemTest < Minitest::Test

  def setup
    # -- First Item's information --
    #          (from csv)
    # NOTE - The description is only an except.
    # NOTE - DO NOT try to match the description value (@repo.all[0].description)
    @headers = [:id, :created_at, :merchant_id, :name, :description, :unit_price, :updated_at]
    # --- CSVParse created hash set ---
    @hash = {
              :id             => "263395237",
              :name           => "510+ RealPush Icon Set",
              :description    => "You&#39;ve got a total socialmedia iconset!", # NOTE - excerpt!
              :unit_price     => "1200",
              :merchant_id    => "12334141",
              :created_at     => "2016-01-11 09:34:06 UTC",
              :updated_at     => "2007-06-04 21:35:10 UTC"
    }
    @item = Item.new(@hash)
    price = @hash[:unit_price].chars.insert(-3, ".").join
    @big_decimal = BigDecimal.new(price, 4)
    @price_as_float = 12.00
    # -----------------------------------
  end


  def test_it_exists
    assert_instance_of Item, @item
  end

  def test_it_gets_attributes
    # -- Read Only --
    assert_equal 263395237, @item.id
    assert_instance_of Time, @item.created_at
    assert_equal @hash[:created_at], @item.created_at.to_s
    assert_equal 12334141, @item.merchant_id
    # TO DO - Assert we cannot write to these values https://docs.ruby-lang.org/en/2.1.0/MiniTest/Assertions.html
    # -- Accessible --
    assert_equal @hash[:name], @item.name
    assert_equal @hash[:description], @item.description
    assert_equal @big_decimal, @item.unit_price
    assert_instance_of Time, @item.updated_at
    assert_equal @hash[:updated_at], @item.updated_at.to_s
    # TO DO - Assert we can write to these values
  end

  def test_it_can_get_unit_price_in_dollars
    assert_equal @price_as_float, @item.unit_price_to_dollars
  end

  def test_it_can_make_updates_with_permissions
    now = Time.now
    hash = {id: "NOPE", created_at: "NOPE", merchant_id: "NOPE",
            name: "YES", description: "YES", unit_price: 1000,
            updated_at: now }
    @item.make_updates(hash)
    # --- denied ---
    refute_equal "NOPE", @item.id
    refute_equal "NOPE", @item.created_at
    refute_equal "NOPE", @item.merchant_id
    # --- allowed ---
    assert_equal "YES", @item.name
    assert_equal "YES", @item.description
    assert_equal 10.0,  @item.unit_price
    assert_equal now.to_s, @item.updated_at.to_s
  end


end
