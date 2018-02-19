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

end
