require 'minitest/autorun'
require 'minitest/pride'
require './lib/item_repo'
require './lib/cleaner'

class ItemRepositoryTest < Minitest::Test

  def setup
    @item_repository = ItemRepository.new
    @cleaner = Cleaner.new
  end

  def test_it_exists
    assert_instance_of ItemRepository, @item_repository
  end

  def test_it_returns_all_items
    assert_equal 1367, @item_repository.all.length
  end

  def test_it_can_find_by_id
    # require 'pry'; binding.pry
      assert_equal 263538760, @item_repository.find_item_by_id(263538760).id
      assert_equal "Puppy blankie", @item_repository.find_item_by_id(263538760).name
      assert_equal nil, @item_repository.find_item_by_id(1)
  end

  def test_item_objects
    csv = (@cleaner.open_csv('./data/items.csv'))
    assert_equal 1367, @item_repository.item_objects(csv).length
    # require 'pry'; binding.pry
    assert_equal "Free standing Woden letters", @item_repository.item_objects(csv)[3].name
  end

  def test_it_finds_item_by_name
    assert_equal "Puppy blankie", @item_repository.find_by_name("Puppy blankie").name
    assert_equal 263538760, @item_repository.find_by_name("Puppy blankie").id
    assert_equal nil, @item_repository.find_by_name("SalesEngine")
  end

  def test_it_finds_all_with_description
    expected = "A large Yeti of sorts, casually devours a cow as the others watch numbly."
    assert_equal expected, @item_repository.find_all_with_description(expected)[0].description
    assert_equal 263550472, @item_repository.find_all_with_description(expected).first.id

    bad_case = "A LARGE yeti of SOrtS, casually devoURS a COw as the OTHERS WaTch NUmbly."
    assert_equal expected, @item_repository.find_all_with_description(bad_case)[0].description
    assert_equal 263550472, @item_repository.find_all_with_description(expected).first.id

    description = "Sales Engine is a relational database"
    assert_equal 0, @item_repository.find_all_with_description(description).length
  end

  def test_it_finds_all_by_price
    # expected = BigDecimal.new(25)
    assert_equal 79, @item_repository.find_all_by_price(BigDecimal.new(25))
    assert_equal 63, @item_repository.find_all_by_price(BigDecimal.new(10))
    assert_equal 0, @item_repository.find_all_by_price(BigDecimal.new(20000))
  end
end
