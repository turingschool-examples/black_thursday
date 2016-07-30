require './test/test_helper'
require './lib/item'

class ItemTest < Minitest::Test
  def item_test_setup
    [ Item.new({  :id          => "263395617",
                  :name        => "Glitter scrabble frames",
                  :description => "Glitter scrabble frames \n\nAny colour glitter \nAny wording\n\nAvailable colour scrabble tiles\nPink\nBlue\nBlack\nWooden",
                  :unit_price  => "1300",
                  :created_at  => "2016-01-11 11:51:37 UTC",
                  :updated_at  => "1993-09-29 11:56:40 UTC",
                  :merchant_id => "12334185" }),

    Item.new({    :id          => "263396279",
                  :name        => "Eule - Topflappen, handgehäkelt, Paar",
                  :description =>
                  "Handgerfertigete Topflappen in Form einer Eule. Die Topflappen wurden aus Wolle gehäkelt. Als Augen wurden Knöpfe verwendet.\n\nDer Verkauf erfolgt paarweise.\n\nHandmade in Germany\n\nMasse: Länge 22,5cm; Breite (breiteste Stelle) 17 cm",
                  :unit_price  => "1490",
                  :created_at  => "2016-01-11 10:06:10 UTC",
                  :updated_at  => "1995-03-08 17:49:21 UTC",
                  :merchant_id => "12334213" }),

    Item.new({    :id          => "263397059",
                  :name        => "Etre ailleurs",
                  :description =>
                  "Acrylique sur carton entoilé exécutée en 2013\nFormat : 27 x 41 cm\nCarton entoilé - non encadré\nArtiste : Flavien Couche - Artiste côté Akoun\n\nTABLEAU VENDU AVEC FACTURE ET CERTIFICAT D&#39;AUTHETICITE\n\nwww.flavien-couche.com",
                  :unit_price  => "13000",
                  :created_at  => "2016-01-11 11:30:35 UTC",
                  :updated_at  => "2007-07-24 05:54:52 UTC",
                  :merchant_id => "12334195" }) ]
  end

  def test_it_creates_a_new_item
    item = item_test_setup

    assert_instance_of Item, item[0]
    assert_instance_of Item, item[1]
    assert_instance_of Item, item[2]
  end

  def test_it_finds_an_item_id
    item = item_test_setup

    assert_equal 263395617, item[0].id
    assert_equal 263396279, item[1].id
    assert_equal 263397059, item[2].id
  end

  def test_it_finds_an_item_name
    item = item_test_setup

    assert_equal "Glitter scrabble frames",               item[0].name
    assert_equal "Eule - Topflappen, handgehäkelt, Paar", item[1].name
    assert_equal "Etre ailleurs",                         item[2].name
  end

  def test_it_finds_an_item_description
    item = item_test_setup

    description = "Glitter scrabble frames \n\nAny colour glitter \nAny wording\n\nAvailable colour scrabble tiles\nPink\nBlue\nBlack\nWooden"
    assert_equal description, item[0].description

    description = "Handgerfertigete Topflappen in Form einer Eule. Die Topflappen wurden aus Wolle gehäkelt. Als Augen wurden Knöpfe verwendet.\n\nDer Verkauf erfolgt paarweise.\n\nHandmade in Germany\n\nMasse: Länge 22,5cm; Breite (breiteste Stelle) 17 cm"
    assert_equal description, item[1].description

    description = "Acrylique sur carton entoilé exécutée en 2013\nFormat : 27 x 41 cm\nCarton entoilé - non encadré\nArtiste : Flavien Couche - Artiste côté Akoun\n\nTABLEAU VENDU AVEC FACTURE ET CERTIFICAT D&#39;AUTHETICITE\n\nwww.flavien-couche.com"
    assert_equal description, item[2].description

  end

  def test_it_finds_when_an_item_was_created
    item = item_test_setup

    assert_equal Time.parse("2016-01-11 11:51:37 UTC"), item[0].created_at
    assert_equal Time.parse("2016-01-11 10:06:10 UTC"), item[1].created_at
    assert_equal Time.parse("2016-01-11 11:30:35 UTC"), item[2].created_at
  end

  def test_it_finds_when_an_item_was_updated
    item = item_test_setup

    assert_equal Time.parse("1993-09-29 11:56:40 UTC"), item[0].updated_at
    assert_equal Time.parse("1995-03-08 17:49:21 UTC"), item[1].updated_at
    assert_equal Time.parse("2007-07-24 05:54:52 UTC"), item[2].updated_at
  end

  def test_it_finds_an_item_related_merchant_id
    item = item_test_setup

    assert_equal 12334185, item[0].merchant_id
    assert_equal 12334213, item[1].merchant_id
    assert_equal 12334195, item[2].merchant_id
  end

  def test_it_converts_an_item_price_to_dollars
    item = item_test_setup

    assert_equal 13,   item[0].unit_price_to_dollars
    assert_equal 14.9, item[1].unit_price_to_dollars
    assert_equal 130,  item[2].unit_price_to_dollars
  end
end
