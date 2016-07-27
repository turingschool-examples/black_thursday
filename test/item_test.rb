require './test/test_helper'
require './lib/item'

class ItemTest < Minitest::Test
  def test_initializing_with_a_hash
    item = Item.new({:name => "Jean"})

    assert_equal "Jean", item.name
  end

  def test_it_has_all_the_things
    item = Item.new({:id => 2663713, :name => "Jean", :description => "Whatever", :unit_price => 10.997,
      :merchant_id => 5, :created_at => Time.now, :updated_at => Time.now})

      assert_equal 2663713, item.id
      assert_equal "Jean", item.name
      assert_equal "Whatever", item.description
      assert_equal 11, item.unit_price
      assert_equal 5, item.merchant_id
      assert_respond_to item, :created_at
      assert_respond_to item, :updated_at
  end

  def test_it_accepts_partial_data
    item = Item.new({:id => 1, :name => "Tiny store"})
    assert_equal 1, item.id
    assert_equal nil, item.description
  end

  def test_unit_price_is_big_decimal
    item_details = {:id => 263396517,
                    :name => "Course contre la montre",
                    :description => "Acrylique sur toile exécutée en 2013
                    Format : 46 x 38 cm
                    Toile sur châssis en bois - non encadré
                    Artiste : Flavien Couche - Artiste côté Akoun

                    TABLEAU VENDU AVEC FACTURE ET CERTIFICAT D&#39;AUTHETICITE

                    www.flavien-couche.com",
                    :unit_price => 40000,
                    :merchant_id => 12334195,
                    :created_at => "1994-05-07 23:38:43 UTC",
                    :updated_at => "2016-01-11 11:30:35 UTC"}
    item = Item.new(item_details)
    assert_equal BigDecimal, item.unit_price.class
    assert_equal 40000, item.unit_price
  end

end
