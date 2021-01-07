require 'CSV'
require './test/test_helper'

class ItemsRepoTest < Minitest::Test

  def setup
    @engine = mock
    @dummy_repo = ItemsRepo.new("./dummy_data/dummy_items.csv", @engine)
  end

  def test_it_is
    assert_instance_of ItemsRepo, @dummy_repo
  end

  def test_it_has_attributes
    assert_instance_of Hash , @dummy_repo.items
  end

  def test_it_can_populate
    assert_instance_of Hash, @dummy_repo.populate_items
  end

  def test_it_can_gather_all_items
    assert_instance_of Item, @dummy_repo.all.values[0]
    assert_instance_of Item, @dummy_repo.all.values[-1]
    assert_equal 4, @dummy_repo.all.values.length
  end

  def test_it_can_find_by_id
    assert_instance_of Item, @dummy_repo.find_by_id("123")
    assert_nil @dummy_repo.find_by_id("111111")
  end

  def test_it_can_find_by_price
    assert_instance_of Array, @dummy_repo.find_by_price(14900)
    assert_instance_of Item,  @dummy_repo.find_by_price(200)[0]
    assert_instance_of BigDecimal, @dummy_repo.find_by_price(200)[0].unit_price
    assert_instance_of Item,  @dummy_repo.find_by_price(46000)[-1]
  end


  def test_it_can_find_by_name
    assert_equal "345", @dummy_repo.find_by_name("etsy").id
  end

  def test_it_can_find_by_description
    data_set = @dummy_repo.find_all_with_description("Size 3m")

    sub_str = ["Size","3m"]
    data_set.each do |item|
      assert_equal true, item.description.include?("size") || item.description.include?("3m")
    end
  end

  def test_it_can_find_by_price_range
    actual = @dummy_repo.find_all_by_price_in_range(100..60000)
    actual_empty = @dummy_repo.find_all_by_price_in_range(1000000..2000000)
    assert_equal 3, actual.count
    assert_equal true, actual.all?{|item| item.class == Item}
    assert_equal 0, actual_empty.count
    assert_equal [], actual_empty
  end

  def test_update_item
    @dummy_repo.find_by_name("amazon")
    assert_equal "amazon", @dummy_repo.all.values[2].name
    @dummy_repo.find_by_price(4500)
    assert_equal 4500, @dummy_repo.all.values[2].unit_price
    @dummy_repo.find_all_with_description("sell things")
    assert_equal "we sell things", @dummy_repo.all.values[2].description
    @dummy_repo.update({id: "567", name: "ebay", description: "we use to sell things", unit_price: 6400})
    @dummy_repo.find_by_name("ebay")
    assert_equal "ebay", @dummy_repo.all.values[2].name
    @dummy_repo.find_by_price(6400)
    assert_equal 6400, @dummy_repo.all.values[2].unit_price
  end

  def test_it_can_find_merchant_id
    actual = @dummy_repo.find_all_by_merchant_id("1").flatten
    assert_equal "1",actual[1].merchant_id
    assert_instance_of Item, actual[1]
  end

  def test_it_can_create_new_item
    data ={
      :id => "910",
      :name => "chipotle",
      :description => "burritos!",
      :unit_price => "49000",
      :merchant_id =>	"5",
      :created_at => "2125-09-22 09:34:06 UTC",
      :updated_at => "2034-09-04 21:35:10 UTC"
    }
    @dummy_repo.create(data)
  end

  def test_it_can_delete_items
    data ={
      :id => "790",
      :name => "chipotle",
      :description => "burritos!",
      :unit_price => "49000",
      :merchant_id =>	"5",
      :created_at => "2125-09-22 09:34:06 UTC",
      :updated_at => "2034-09-04 21:35:10 UTC"
    }

    @dummy_repo.create(data)
    @dummy_repo.delete(790)

    assert_equal true, @dummy_repo.all.keys.last == "789"
  end


end
