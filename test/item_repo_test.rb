require_relative 'test_helper'
require_relative '../lib/item_repo'

class ItemRepoTest < Minitest::Test

  def setup
    item_array = [{id: 263395237, name: "Cow1" , description: "animal 1", unit_price: "1400", created_at: "2016-01-11 11:51:37 UTC", updated_at: "2016-01-11 11:51:37 UTC", merchant_id: "12334195"},
      {id: 263395238, name: "Cow1", description: "animal 1", unit_price: "1400", created_at: "2016-01-11 11:51:37 UTC", updated_at: "2016-01-11 11:51:37 UTC", merchant_id: "12334195"},
      {id: 263395239, name: "cow1", description: "animal 1", unit_price: "1400", created_at: "2016-01-11 11:51:37 UTC", updated_at: "2016-01-11 11:51:37 UTC", merchant_id: "12334195"},
      {id: 263395210, name: "Moose1", description: "animal 2", unit_price: "1700", created_at: "2016-01-11 11:51:37 UTC", updated_at: "2016-01-11 11:51:37 UTC", merchant_id: "12334101"},
      {id: 263395211, name: "Moose2", description: "animal 3", unit_price: "1800", created_at: "2016-01-11 11:51:37 UTC", updated_at: "2016-01-11 11:51:37 UTC", merchant_id: "12334102"},
      {id: 263395212, name: "Pig", description: "animal 4", unit_price: "1400", created_at: "2016-01-11 11:51:37 UTC", updated_at: "2016-01-11 11:51:37 UTC", merchant_id: "12334103"}]
    @item_repo = ItemRepo.new(item_array)
  end

  def test_it_exists
    assert_instance_of ItemRepo, @item_repo
  end

  def test_it_returns_all_items
    assert_equal @item_repo.items, @item_repo.all
  end

  def test_it_finds_item_by_id
    assert_equal @item_repo.items[0], @item_repo.find_by_id(263395237)
    assert_equal nil, @item_repo.find_by_id(123456)
  end

  def test_it_finds_item_by_name
    assert_equal @item_repo.items[3], @item_repo.find_by_name("Moose1")
    assert_equal nil, @item_repo.find_by_name("Horse")
  end

  def test_it_finds_all_items_with_description
    assert_equal [@item_repo.items[0], @item_repo.items[1], @item_repo.items[2]], @item_repo.find_all_with_description("animal 1")
    assert_equal [], @item_repo.find_all_with_description("it's doesn't have one")
  end
  
  def test_it_finds_all_items_by_price
    assert_equal [@item_repo.items[0], @item_repo.items[1], @item_repo.items[2], @item_repo.items[5]], @item_repo.find_all_by_price(14)
    assert_equal [], @item_repo.find_all_by_price(10)
  end
  
  def test_it_finds_all_items_by_price_range
    assert_equal [@item_repo.items[3], @item_repo.items[4]], @item_repo.find_all_by_price_in_range(17..20)
    assert_equal [], @item_repo.find_all_by_price_in_range(10..13)
  end

  def test_it_finds_all_items_by_merchant_id
    assert_equal [@item_repo.items[0], @item_repo.items[1], @item_repo.all[2]], @item_repo.find_all_by_merchant_id(12334195)
    assert_equal [], @item_repo.find_all_by_merchant_id(123456)
  end

  def test_it_creates_item_with_attributes
    refute_instance_of Item, @item_repo.items[6]
    @item_repo.create({:id          => "1",
                       :name        => "Eagle",
                       :description => "animal 7",
                       :unit_price  => "1099",
                       :created_at  => "2016-01-11 11:51:37 UTC",
                       :updated_at  => "2016-01-11 11:51:37 UTC",
                       :merchant_id => "2"})
    assert_instance_of Item, @item_repo.items[6]
  end

  def test_it_updates_item_attributes
    refute_equal "Bat", @item_repo.items[5].name
    refute_equal "animal 100", @item_repo.items[5].description
    refute_equal "21", @item_repo.items[5].unit_price

    current_time = Time.now.to_s

    @item_repo.update(263395212, {
      :id           => "363395250",
      :name         => "Bat",
      :description  => "animal 100",
      :unit_price   => 21,
      :created_at   => "2016-01-11 11:51:37 UTC",
      :updated_at   => current_time,
      :merchant_id  => "12334104"
      })

    assert_equal "Bat", @item_repo.items[5].name
    assert_equal "animal 100", @item_repo.items[5].description
    assert_equal 21, @item_repo.items[5].unit_price
    assert_equal 263395212, @item_repo.items[5].id
    assert_equal "2016-01-11 11:51:37 UTC", @item_repo.items[5].created_at.to_s
    assert_equal current_time, @item_repo.items[5].updated_at.to_s
    assert_equal 12334103, @item_repo.items[5].merchant_id
  end

  def test_it_deletes_item_by_id
    assert_instance_of Item, @item_repo.find_by_id(263395237)
    @item_repo.delete(263395237)
    assert_equal nil, @item_repo.find_by_id(263395237)
  end
  
end
