require_relative "../test/test_helper"
require_relative "../lib/item"
require_relative "../lib/item_repo"

class ItemRepoTest < Minitest::Test

  def setup
    @item_repo = ItemRepo.new
    
    @item_repo.items = [
      @item_1 = Item.new({id: 263395237, name: "Cow1" , description: "animal 1", unit_price: "1400", created_at: "2016-01-11 11:51:37 UTC", updated_at: "2016-01-11 11:51:37 UTC", merchant_id: "12334195"}),
      @item_2 = Item.new({id: 263395238, name: "Cow1", description: "animal 1", unit_price: "1400", created_at: "2016-01-11 11:51:37 UTC", updated_at: "2016-01-11 11:51:37 UTC", merchant_id: "12334195"}),
      @item_3 = Item.new({id: 263395239, name: "Cow1", description: "animal 1", unit_price: "1400", created_at: "2016-01-11 11:51:37 UTC", updated_at: "2016-01-11 11:51:37 UTC", merchant_id: "12334195"}),
      @item_4 = Item.new({id: 263395210, name: "Moose1", description: "animal 2", unit_price: "1700", created_at: "2016-01-11 11:51:37 UTC", updated_at: "2016-01-11 11:51:37 UTC", merchant_id: "12334101"}),
      @item_5 = Item.new({id: 263395211, name: "Moose2", description: "animal 3", unit_price: "1800", created_at: "2016-01-11 11:51:37 UTC", updated_at: "2016-01-11 11:51:37 UTC", merchant_id: "12334102"}),
      @item_6 = Item.new({id: 263395212, name: "Pig", description: "animal 4", unit_price: "1400", created_at: "2016-01-11 11:51:37 UTC", updated_at: "2016-01-11 11:51:37 UTC", merchant_id: "12334103"}),
      @item_7 = Item.new({id: 263395213, name: "Cat", description: "animal 5", unit_price: "2000", created_at: "2016-01-11 11:51:37 UTC", updated_at: "2016-01-11 11:51:37 UTC", merchant_id: "12334104"}),
      @item_8 = Item.new({id: 263395214, name: "Dog", description: "animal 6", unit_price: "1400", created_at: "2016-01-11 11:51:37 UTC", updated_at: "2016-01-11 11:51:37 UTC", merchant_id: "12334104"})
  ]
  end

  def test_it_exists
    assert_instance_of ItemRepo, @item_repo
  end
  
  def test_it_returns_all_items
    assert_equal @item_repo.items, @item_repo.all
  end
  
  def test_it_returns_item_by_id
    assert_equal @item_1, @item_repo.find_by_id(263395237)
    assert_equal nil, @item_repo.find_by_id(12345678)
  end
  
  def test_it_returns_item_by_name
    assert_equal @item_8, @item_repo.find_by_name("Dog")
    assert_equal nil, @item_repo.find_by_name("Horse")
  end
  
  def test_it_finds_all_items_with_description
    assert_equal [@item_1, @item_2, @item_3], @item_repo.find_all_with_description("animal 1")
    assert_equal [], @item_repo.find_all_with_description("it's doesn't have one")
  end
  
  def test_it_finds_all_items_by_price
    assert_equal [@item_1, @item_2, @item_3, @item_6, @item_8], @item_repo.find_all_by_price(1400)
    assert_equal [], @item_repo.find_all_by_price(1000)
  end
  
  def test_it_finds_all_items_by_price_range
    assert_equal [@item_4, @item_5, @item_7], @item_repo.find_all_by_price_in_range([1700,2000])
    assert_equal [], @item_repo.find_all_by_price_in_range([1000,1300])
  end
  
  def test_it_returns_all_items_by_merchant_id
    assert_equal [@item_1, @item_2, @item_3], @item_repo.find_all_by_merchant_id(12334195)
    assert_equal [], @item_repo.find_all_by_merchant_id(12345678)
  end
  
  def test_it_creates_item_with_attributes
  assert_instance_of Item, @item_repo.create({
  :id          => 1,
  :name        => "Eagle",
  :description => "animal 7",
  :unit_price  => BigDecimal.new(10.99,4),
  :created_at  => Time.now,
  :updated_at  => Time.now,
  :merchant_id => 2 
  })
  end
  
  
  def test_it_updates_item_attributes
    refute_equal "Bat", @item_8.name 
    refute_equal "animal 100", @item_8.description
    refute_equal "2100", @item_8.unit_price
    
    @item_repo.update(263395214, {
      :id           => 363395250, 
      :name         => "Bat", 
      :description  => "animal 100", 
      :unit_price   => 2100, 
      :created_at   => Time.now, 
      :updated_at   => Time.now, 
      :merchant_id  => "12334104"
      })
    
      assert_equal "Bat", @item_8.name 
      assert_equal "animal 100", @item_8.description
      assert_equal "2100", @item_8.unit_price
      assert_equal 263395214, @item_8.id 
      assert_equal "2016-01-11 11:51:37 UTC", @item_8.created_at
      assert_equal "2016-01-11 11:51:37 UTC", @item_8.updated_at
      assert_equal "12334104", @item_8.merchant_id
  end
  
  def test_it_deletes_item_by_id
    @item_repo.delete(263395237)
    assert_equal nil, @item_repo.find_by_id(263395237)
  end  
  
end