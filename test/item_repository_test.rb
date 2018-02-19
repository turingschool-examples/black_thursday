require_relative 'test_helper'
require_relative '../lib/item_repository'

class ItemRepositoryTest < Minitest::Test

  def setup
    @item_repo = ItemRepository.new('./test/fixtures/items_sample.csv')
  end

  def test_if_it_exists
    assert_instance_of ItemRepository, @item_repo
  end

  def test_if_item_repository_has_items
    assert_instance_of Array, @item_repo.all
    assert_equal 26, @item_repo.all.count
    assert @item_repo.all.all? { |item| item.is_a?(Item)}
  end

  def test_if_it_can_load_correct_ids
    assert_equal 263445483, @item_repo.all.first.id
    assert_equal 263396013, @item_repo.all[4].id
  end

  def test_if_it_can_load_correct_names
    assert_equal "Art Deco Stained Glass", @item_repo.all.first.name
    assert_equal "Free standing Woden letters", @item_repo.all[4].name
    assert_equal "bracciale rigido margherite", @item_repo.all.last.name
  end

  def test_if_it_can_load_correct_description
    assert @item_repo.all.first.description.include?("This piece is foil/sol")
    assert @item_repo.all[4].description.include?("Free standing wooden lett")
    assert @item_repo.all.last.description.include?("non diventiamo artisti")
  end

  def test_it_can_find_an_item_by_id
    result = @item_repo.find_by_id(263445483)

    assert_instance_of Item, result
    assert_equal 263445483, result.id
    assert_equal "Art Deco Stained Glass", result.name
    assert result.description.include?("This piece is foil/solder")
    assert_equal 12336075, result.merchant_id
  end

  def test_it_can_find_another_item_by_id
    result = @item_repo.find_by_id(263395721)

    assert_instance_of Item, result
    assert_equal 263395721, result.id
    assert_equal "Disney scrabble frames", result.name
    assert result.description.include?("glitter available and")
    assert_equal 12334185, result.merchant_id
  end

  def test_it_can_return_nil_when_there_is_no_match_for_id
    result = @item_repo.find_by_id(32334388)

    assert_nil result
  end

  def test_it_can_find_item_by_name
    result = @item_repo.find_by_name("Disney scrabble frames")

    assert_instance_of Item, result
    assert_equal 263395721, result.id
    assert_equal "Disney scrabble frames", result.name
    assert result.description.include?("glitter available and")
    assert_equal 12334185, result.merchant_id
  end

  def test_it_can_find_another_item_by_name
    result = @item_repo.find_by_name("Art Deco Stained Glass")

    assert_instance_of Item, result
    assert_equal 263445483, result.id
    assert_equal "Art Deco Stained Glass", result.name
    assert result.description.include?("This piece is foil/solder")
    assert_equal 12336075, result.merchant_id
  end

  def test_it_can_find_item_regardless_of_item_name_case
    result = @item_repo.find_by_name("DiSNEY sCRAbble fraMES")

    assert_instance_of Item, result
    assert_equal 263395721, result.id
    assert_equal "Disney scrabble frames", result.name
    assert result.description.include?("glitter available and")
    assert_equal 12334185, result.merchant_id
  end

  def test_it_can_return_nil_when_there_is_no_match_for_item_name
    result = @item_repo.find_by_name("Mike Dao's Muffin")

    assert_nil result
  end

  def test_it_can_find_all_items_with_same_item_description
    result = @item_repo.find_all_with_description("Hand")

    assert result.class == Array
    assert_instance_of Item, result.first
    assert_equal "Eule - Topflappen, handgehäkelt, Paar", result.first.name
    assert result.last.name.include?("HandMade pillow cases")
    assert_equal 263396279, result.first.id
    assert_equal 263398203, result.last.id
  end

  def test_it_returns_empty_array_when_there_is_no_match_for_item_description
    result = @item_repo.find_all_with_description("Mike Dao's Muffin")

    assert_equal [], result
  end

  def test_it_can_find_all_items_by_merchant_id
    result = @item_repo.find_all_by_merchant_id(12334185)

    assert result.class == Array
    assert_instance_of Item, result.first
    assert_equal 263395617, result.first.id
    assert_equal 263396013, result.last.id
    assert_equal "Glitter scrabble frames", result.first.name
    assert_equal "Free standing Woden letters", result.last.name
    assert result.first.description.include?("Glitter scrabble frames")
    assert result.last.description.include?("Free standing wooden")
    assert_equal 12334185, result.first.merchant_id
    assert_equal 12334185, result.last.merchant_id
  end

  def test_it_returns_empty_array_when_there_is_no_match_for_merchant_id
    result = @item_repo.find_all_by_merchant_id(6666666)

    assert result.class == Array
    assert_equal [], result
  end

  def test_it_can_find_all_items_with_same_price
    result = @item_repo.find_all_by_price(60000)

    assert result.class == Array
    assert_instance_of Item, result.first
    assert_equal "Introspection virginalle", result.first.name
    assert_equal "Les raisons", result.last.name
    assert_equal 263397313, result.first.id
    assert_equal 263398653, result.last.id
  end

  def test_it_returns_empty_array_when_there_is_no_match_for_price
    result = @item_repo.find_all_by_price(12345)

    assert_equal [], result
  end

end
