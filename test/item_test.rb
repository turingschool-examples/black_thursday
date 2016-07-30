require './test/test_helper'
require './lib/item'

class ItemTest < Minitest::Test
  attr_reader :item1,
              :item2,
              :item3

  def setup
    @item1 = Item.new({ :id          => "263395617",
                        :name        => "Glitter scrabble frames",
                        :description => "Glitter scrabble frames \n\nAny colour glitter \nAny wording\n\nAvailable colour scrabble tiles\nPink\nBlue\nBlack\nWooden",
                        :unit_price  => "1300",
                        :created_at  => "2016-01-11 11:51:37 UTC",
                        :updated_at  => "1993-09-29 11:56:40 UTC",
                        :merchant_id => "12334185" })

    @item2 = Item.new({ :id          => "263396279",
                        :name        => "Eule - Topflappen, handgehäkelt, Paar",
                        :description =>
                        "Handgerfertigete Topflappen in Form einer Eule. Die Topflappen wurden aus Wolle gehäkelt. Als Augen wurden Knöpfe verwendet.\n\nDer Verkauf erfolgt paarweise.\n\nHandmade in Germany\n\nMasse: Länge 22,5cm; Breite (breiteste Stelle) 17 cm",
                        :unit_price  => "1490",
                        :created_at  => "2016-01-11 10:06:10 UTC",
                        :updated_at  => "1995-03-08 17:49:21 UTC",
                        :merchant_id => "12334213" })

    @item3 = Item.new({ :id          => "263397059",
                        :name        => "Etre ailleurs",
                        :description =>
                        "Acrylique sur carton entoilé exécutée en 2013\nFormat : 27 x 41 cm\nCarton entoilé - non encadré\nArtiste : Flavien Couche - Artiste côté Akoun\n\nTABLEAU VENDU AVEC FACTURE ET CERTIFICAT D&#39;AUTHETICITE\n\nwww.flavien-couche.com",
                        :unit_price  => "13000",
                        :created_at  => "2016-01-11 11:30:35 UTC",
                        :updated_at  => "2007-07-24 05:54:52 UTC",
                        :merchant_id => "12334195" })
  end

  def test_it_creates_a_new_item
    assert_instance_of Item, item1
    assert_instance_of Item, item2
    assert_instance_of Item, item3
  end

  def test_it_finds_an_item_id
    assert_equal 263395617, item1.id
    assert_equal 263396279, item2.id
    assert_equal 263397059, item3.id
  end

  def test_it_finds_an_item_name
    assert_equal "Glitter scrabble frames",               item1.name
    assert_equal "Eule - Topflappen, handgehäkelt, Paar", item2.name
    assert_equal "Etre ailleurs",                         item3.name
  end

  def test_it_finds_an_item_description
    description = "Glitter scrabble frames \n\nAny colour glitter \nAny wording\n\nAvailable colour scrabble tiles\nPink\nBlue\nBlack\nWooden"
    assert_equal description, item1.description

    description = "Handgerfertigete Topflappen in Form einer Eule. Die Topflappen wurden aus Wolle gehäkelt. Als Augen wurden Knöpfe verwendet.\n\nDer Verkauf erfolgt paarweise.\n\nHandmade in Germany\n\nMasse: Länge 22,5cm; Breite (breiteste Stelle) 17 cm"
    assert_equal description, item2.description

    description = "Acrylique sur carton entoilé exécutée en 2013\nFormat : 27 x 41 cm\nCarton entoilé - non encadré\nArtiste : Flavien Couche - Artiste côté Akoun\n\nTABLEAU VENDU AVEC FACTURE ET CERTIFICAT D&#39;AUTHETICITE\n\nwww.flavien-couche.com"
    assert_equal description, item3.description

  end

  def test_it_finds_when_an_item_was_created
    assert_equal Time.parse("2016-01-11 11:51:37 UTC"), item1.created_at
    assert_equal Time.parse("2016-01-11 10:06:10 UTC"), item2.created_at
    assert_equal Time.parse("2016-01-11 11:30:35 UTC"), item3.created_at
  end

  def test_it_finds_when_an_item_was_updated
    assert_equal Time.parse("1993-09-29 11:56:40 UTC"), item1.updated_at
    assert_equal Time.parse("1995-03-08 17:49:21 UTC"), item2.updated_at
    assert_equal Time.parse("2007-07-24 05:54:52 UTC"), item3.updated_at
  end

  def test_it_finds_an_item_related_merchant_id
    assert_equal 12334185, item1.merchant_id
    assert_equal 12334213, item2.merchant_id
    assert_equal 12334195, item3.merchant_id
  end

  def test_it_converts_an_item_price_to_dollars
    assert_equal 13,  item1.unit_price_to_dollars
    assert_equal 14.9,  item2.unit_price_to_dollars
    assert_equal 130, item3.unit_price_to_dollars
  end
end
