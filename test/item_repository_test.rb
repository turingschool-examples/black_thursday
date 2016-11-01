require 'minitest/autorun'
require 'minitest/pride'
require './lib/sales_engine'
require './lib/item_repository'

class ItemRepositoryTest < Minitest::Test

  attr_reader :sales_engine

  def setup
    @sales_engine = SalesEngine.from_csv({
      :items => "./data_fixtures/items_fixture.csv"
    })
  end

  def test_all_returns_an_array_of_item_instances
    item_repository = sales_engine.items
    assert_kind_of Array, item_repository.all
  end

  def test_all_returns_an_array_of_all_item_objects
    item_repository = sales_engine.items
    item_repository.all.each {|item| assert_kind_of Item, item}
  end

  def test_all_includes_all_25_item_objects_from_items_fixture
    item_repository = sales_engine.items
    assert_equal 25, item_repository.all.length
  end

  def test_find_by_id_returns_item_instance_with_matching_id
    id = '263395617'
    item_repository = sales_engine.items
    item = item_repository.find_by_id(id)
    assert_kind_of Item, item
    assert_equal id, item.id
  end

  def test_find_by_id_without_match_returns_nil
    id = '99999999'
    item_repository = sales_engine.items
    assert_nil item_repository.find_by_id(id)
  end

  def test_find_by_name_returns_item_instance_with_matching_name
    name = '510+ RealPush Icon Set'
    item_repository = sales_engine.items
    item = item_repository.find_by_name(name)
    assert_kind_of Item, item
    assert_equal name, item.name
  end

  def test_find_by_name_returns_instance_with_matching_name_all_caps
    name_upcase = '510+ REALPUSH ICON SET'
    name = '510+ RealPush Icon Set'
    item_repository = sales_engine.items
    item = item_repository.find_by_name(name_upcase)
    assert_kind_of Item, item
    assert_equal name, item.name
  end

  def test_find_by_name_without_match_returns_nil
    name = '1000-count lot Gary Busey framed portraits'
    item_repository = sales_engine.items
    assert_nil item_repository.find_by_name(name)
  end

  def test_find_all_with_description_without_match_returns_empty_array
    description = 'highlyunlikelydescriptionfragment'
    item_repository = sales_engine.items
    items = item_repository.find_all_with_description(description)
    assert [], items
  end

end