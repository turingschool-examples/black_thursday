require_relative './test_helper'
require_relative '../lib/item_repository'

class ItemRepositoryTest < Minitest::Test

  def test_it_exists
    ir = ItemRepository.new('./test/data/item_sample.csv')
    assert_instance_of ItemRepository, ir
  end

  def test_it_can_create_items
    ir = ItemRepository.new('./test/data/item_sample.csv')
    assert_instance_of Array, ir.create_repo_array("./test/data/item_sample.csv")
  end

  def test_item_repo_has_items
    ir = ItemRepository.new('./test/data/item_sample.csv')
    assert_equal 3, ir.all.count
  end

  def test_it_finds_by_id
    ir = ItemRepository.new('./test/data/item_sample.csv')
    item = ir.all[1]
    assert_equal item, ir.find_by_id(263397059)
  end

  def test_item_repo_can_find_them_by_name
    ir = ItemRepository.new("./test/data/item_sample.csv")
    assert_instance_of Item, ir.find_by_name('Etre ailleurs')
  end

  def test_it_can_find_all_by_description
   ir = ItemRepository.new("./test/data/item_sample.csv")
   assert_equal [], ir.find_all_with_description('Disney glitter frames')
  end

  def test_it_can_find_all_by_price
   ir = ItemRepository.new("./test/data/item_sample.csv")
   price = BigDecimal(12,4)
   assert_equal 1, ir.find_all_by_price(price).length
  end

  def test_it_returns_array_of_items_priced_within_givin_range
   range = (1000.00..1500.00)
   ir = ItemRepository.new("./test/data/item_sample.csv")
   assert_equal 0, ir.find_all_by_price_in_range(range).count
  end

  def test_it_can_find_all_by_merchant_id
   ir = ItemRepository.new("./test/data/item_sample.csv")
   item = ir.all[0]
   assert_instance_of Item, ir.find_all_by_merchant_id(12334141).first
   assert_equal [item], ir.find_all_by_merchant_id(12334141)
  end

  def test_it_can_find_max_id_and_increase_it_by_one
   ir = ItemRepository.new("./test/data/item_sample.csv")
   assert_equal 263398204, ir.new_highest_id
  end

  def test_we_can_create_new_item_and_incriment_its_id_up_one
  ir = ItemRepository.new("./test/data/item_sample.csv")
  new_item = ir.create({:name => 'New_Item'})
  assert_equal 'New_Item', new_item.name
  assert_equal 263398204, new_item.id
  end

  def test_we_can_update_attributes
    ir = ItemRepository.new("./test/data/item_sample.csv")
    ir.create({:name => 'Shoes', :description => 'very comfy', :unit_price => 2000})
    ir.update(263398203, {:name => 'Shiny Shoes', :description => 'even more comfy', :unit_price => 3500})
    updated_item = ir.find_by_id(263398203)
    assert_equal 'Shiny Shoes', updated_item.name
    assert_equal 'even more comfy', updated_item.description
    assert_equal 3500, updated_item.unit_price
  end

  def test_it_can_delete_by_id
    ir = ItemRepository.new('./test/data/item_sample.csv')
    ir.delete(263397059)
    assert_nil ir.find_by_id(263397059)
  end

end
