require './test/minitest_helper'

class ItemTest<Minitest::Test

  def setup
    @ir = ItemRepository.new('./test/fixtures/items_fixtures.csv')
  end

  def test_it_exists
   assert_instance_of ItemRepository, @ir
  end

  def test_item_repo_has_items
   assert_equal 10 , @ir.all.count
   assert_instance_of Array, @ir.all
  end

  def test_it_can_find_item_by_id
   result = @ir.find_by_id(263397059)

   assert_instance_of Item, result
   assert_equal 263397059, result.id
   assert_equal 'Etre ailleurs', result.name
  end

  def test_it_can_find_items_by_name
   result = @ir.find_by_name('Etre ailleurs')
   assert_equal 'Etre ailleurs', result.name
  end

  def test_it_can_find_all_by_description
   result = @ir.find_all_with_description('Disney glitter frames')
   assert_equal 'Disney glitter frames', result.first.description
  end

  def test_it_can_find_all_with_price
   result = @ir.find_all_by_price('1200')
   # binding.pry
   assert_equal 1200, result.first.unit_price
  end

  def test_it_returns_array_of_items_priced_within_givin_range
   range = (1000.00..1500.00)
   result = @ir.find_all_by_price_in_range(range)
   assert_equal 0, result.length
  end

  def test_it_returns_an_array_of_items_associated_with_given_merchant_id
   merchant_id = 12334185#Check string at spec harness
   result = @ir.find_all_by_merchant_id(merchant_id)
   assert_equal 3, result.length
  end

  def test_it_can_find_max_item_id
    result = @ir.find_max_item_id
    assert_equal 263397059, result.id
  end

  def test_we_can_create_new_item_and_incriment_its_id_up_one
    new_item = @ir.create({:name => "Rusty Shoes"})
    assert_equal "Rusty Shoes", new_item.name
    assert_equal 263397060, new_item.id
  end

  def test_we_can_update_attributes
    @ir.create({:name => "Rusty Shoes", :description => "nice", :unit_price => 200})
    @ir.update(263397060, {:name => "Nice Loafers", :description => "hurry up and buy", :unit_price => 2500})

    updated_item = @ir.find_by_id(263397060)

    assert_equal "Nice Loafers", updated_item.name
    assert_equal "hurry up and buy", updated_item.description
    assert_equal 2500, updated_item.unit_price
  end

  def test_we_can_delete_an_item_by_id
    @ir.create({:name => "Rusty Shoes", :description => "nice", :unit_price => 200})
    max_item = @ir.find_max_item_id
    assert_equal 263397060, max_item.id

    @ir.delete(263397060)

    max_item = @ir.find_max_item_id
    assert_equal 263397059, max_item.id
  end
end
