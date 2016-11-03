require_relative 'test_helper'
require_relative '../lib/item_repository'

class ItemRepositoryTest < Minitest::Test
  
   def setup
    parent = Minitest::Mock.new
    @item_repo = ItemRepository.new('./data/test_items.csv', parent)
  end

  def test_it_exists
    assert ItemRepository.new
  end

  def test_it_initializes_with_a_file
    assert ItemRepository.new('./data/test_items.csv')
  end

  def test_it_has_custom_inspect
    assert_equal "#<ItemRepository: 116 rows>", @item_repo.inspect
  end

  def test_find_all_by_merchant_id_calls_parent
    @item_repo.parent.expect(:find_item_merchant_by_merch_id, nil, [5])
    @item_repo.find_item_merchant_by_merch_id(5)
    @item_repo.parent.verify
  end

  def test_it_turns_file_contents_to_CSV_object
    assert_equal CSV, @item_repo.file_contents.class
  end

  def test_it_generates_array_of_item_objects_from_csv_object
    assert @item_repo.all.all?{|row| row.class == Item}
  end

  def test_it_calls_id_of_item_object
    assert_equal 263395237, @item_repo.all[0].id
  end

  def test_it_calls_name_of_item_object
    assert_equal "510+ RealPush Icon Set", @item_repo.all[0].name
  end

  def test_it_retrieves_all_item_objects
    assert_equal Item, @item_repo.all[0].class
    assert_equal 116, @item_repo.all.count
  end

  def test_item_ids_are_uniq
    ids = @item_repo.all {|row| row[:id]}
    assert_equal ids, ids.uniq
  end

  def test_it_finds_item_by_id
    id = 263395237
    item = @item_repo.find_by_id(id)
    assert_equal Item, item.class
    assert_equal id, item.id
  end

  def test_it_returns_nil_if_id_not_found
    id = 123
    item = @item_repo.find_by_id(id)
    assert_equal nil, item
  end

  def test_it_finds_item_by_name
    name = "510+ RealPush Icon Set"
    item = @item_repo.find_by_name(name)
    assert_equal Item, item.class
    assert_equal name, item.name
  end

  def test_it_returns_nil_if_name_not_found
    name = "mike"
    item = @item_repo.find_by_name(name)
    assert_equal nil, item
  end

  def test_it_finds_items_by_description
    description = "custom"
    items = @item_repo.find_all_with_description(description)
    assert_equal Item, items.first.class
    assert_equal 8, items.map{|item| item.description}.count
  end

  def test_it_returns_nil_if_description_not_found
    description = "schutte"
    items = @item_repo.find_all_with_description(description)
    assert_equal [], items.map{|item| item.description}
  end

  def test_it_finds_items_by_price
    price = 12.00
    items = @item_repo.find_all_by_price(price)
    assert_equal Item, items.first.class
    assert_equal 2, items.map{|item| item.unit_price}.count
  end

  def test_it_returns_nil_if_price_not_found
    price = 10000000
    items = @item_repo.find_all_by_price(price)
    assert_equal [], items.map{|item| item.unit_price}
  end

  def test_it_finds_items_by_price_range
    price_range = (0..10)
    items = @item_repo.find_all_by_price_in_range(price_range)
    assert_equal Item, items.first.class
    assert_equal 19, items.count
  end

  def test_it_returns_nil_if_no_items_in_price_range
    price_range = (100000..10000000)
    items = @item_repo.find_all_by_price_in_range(price_range)
    assert_equal [], items.map{|item| item.merchant_id}
  end

  def test_it_finds_items_by_merchant_id
    merchant_id = 12334195
    items = @item_repo.find_all_by_merchant_id(merchant_id)
    assert_equal Item, items.first.class
    assert_equal 12, items.map{|item| item.merchant_id}.count
  end

  def test_it_returns_nil_if_merchant_id_is_not_found
    merchant_id = 10000000
    items = @item_repo.find_all_by_merchant_id(merchant_id)
    assert_equal [], items.map{|item| item.merchant_id}
  end

end
