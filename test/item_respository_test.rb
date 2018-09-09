require 'minitest/autorun'
require 'minitest/pride'
require './lib/item_repository'
require './lib/item'
require 'pry'

class ItemRepositoryTest < Minitest::Test
  def test_it_exists
    item_repository = ItemRepository.new('./data/items.csv')

    assert_instance_of ItemRepository, item_repository
  end

  def test_it_can_load_items
    item_repository = ItemRepository.new('./data/items.csv')

    assert_instance_of Array, item_repository.all
  end

  def test_it_can_find_by_id
    item_repository = ItemRepository.new('./data/items.csv')

    actual = item_repository.find_by_id(263397785)
    assert_instance_of Item, actual
    assert_equal "La prière", actual.name
  end

  def test_it_returns_nil_if_cant_find_id
    item_repository = ItemRepository.new('./data/items.csv')

    actual = item_repository.find_by_id(1)
    assert_nil actual
  end

  def test_it_can_find_by_name
    item_repository = ItemRepository.new('./data/items.csv')

    actual = item_repository.find_by_name("La prière")
    assert_instance_of Item, actual
    assert_equal 263397785, actual.id
  end

  def test_find_name_can_return_nil
    item_repository = ItemRepository.new('./data/items.csv')

    actual = item_repository.find_by_name("Samuel")
    assert_nil actual
  end

  def test_it_can_find_all_with_description
    item_repository = ItemRepository.new('./data/items.csv')
    description = "Acrylique sur toile exécutée en 2013\nFormat : 46 x 38 cm\nToile sur châssis en bois - non encadré\nArtiste : Flavien Couche - Artiste côté Akoun\n\nTABLEAU VENDU AVEC FACTURE ET CERTIFICAT D&#39;AUTHETICITE\n\nwww.flavien-couche.com"
    item_1 = item_repository.find_by_id(263396517)
    assert_equal [item_1], item_repository.find_all_with_description(description)
  end

  def test_it_can_find_all_with_desctiption_and_return_nil
    item_repository = ItemRepository.new('./data/items.csv')

    assert_equal [], item_repository.find_all_with_description("Something Fun!")
  end

  def test_it_can_find_all_by_price
    item_repository = ItemRepository.new('./data/items.csv')

    item_1 = item_repository.find_by_id(263533612)
    item_2 = item_repository.find_by_id(263438579)

    assert_equal [], item_repository.find_all_by_price(0.00)
    assert_equal [item_2,item_1], item_repository.find_all_by_price(17.00)
  end

  def test_it_can_find_all_by_range
    item_repository = ItemRepository.new('./data/items.csv')

    item_1 = item_repository.find_by_id(263397919)
    item_2 = item_repository.find_by_id(263398179)
    item_3 = item_repository.find_by_id(263413443)
    item_4 = item_repository.find_by_id(263414049)
    item_5 = item_repository.find_by_id(263426247)
    item_6 = item_repository.find_by_id(263426657)
    item_7 = item_repository.find_by_id(263458165)
    item_8 = item_repository.find_by_id(263500126)
    item_9 = item_repository.find_by_id(263500990)
    item_10 = item_repository.find_by_id(263501476)
    item_11 = item_repository.find_by_id(263559178)

    assert_equal [item_1,item_2,item_3,item_4,item_5,item_6,item_7,item_8,item_9,item_10,item_11], item_repository.find_all_by_price_in_range(500.00..510.00)
  end

  def test_it_can_find_by_merchant_id
    item_repository = ItemRepository.new('./data/items.csv')

    item_1 = item_repository.find_by_id(263400237)
    item_2 = item_repository.find_by_id(263402963)
    item_3 = item_repository.find_by_id(263504382)
    item_4 = item_repository.find_by_id(263510372)

    assert_equal [item_1,item_2,item_3,item_4], item_repository.find_all_by_merchant_id(12334411)

    assert_equal [], item_repository.find_all_by_merchant_id(1234566789)
  end

  def test_it_can_update_attributes_and_time
    item_repository = ItemRepository.new('./data/items.csv')

    attributes = {name: "My Favorite Store", description: "It's just the best store ever!", unit_price: 5000}

    item = item_repository.update(263400237, attributes)
    item_1 = item_repository.find_by_id(263400237)

    assert_equal 263400237, item_1.id
    assert_equal "My Favorite Store", item_1.name
    assert_equal "It's just the best store ever!", item_1.description
    refute "2016-01-11 12:29:33 UTC" == item_1.updated_at
  end

  def test_it_can_delete_merchants_by_id
    item_repository = ItemRepository.new('./data/items.csv')
    item = item_repository.find_by_id(263400237)
    item_repository.delete(263400237)

    refute item_repository.items.include?(item)
  end

end
