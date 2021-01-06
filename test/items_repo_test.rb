require 'CSV'
require './test/test_helper'

class ItemsRepoTest < Minitest::Test

  def setup
    @repo = ItemsRepo.new("./data/items.csv")
    @dummy_repo = ItemsRepo.new("./dummy_data/dummy_items.csv")
  end

  def test_it_is
    assert_instance_of ItemsRepo, @repo
  end

  def test_it_has_attributes
    assert_instance_of Hash , @repo.items
  end

  def test_it_can_populate
  	assert_instance_of Hash, @repo.populate_items
  end

  def test_it_can_gather_all_items
    assert_instance_of Item, @repo.all.values[0]
    assert_instance_of Item, @repo.all.values[-1]
    assert_equal 1367, @repo.all.values.length
  end

  def test_it_can_find_by_id
    assert_instance_of Item, @repo.find_by_id("263395237")
    assert_nil @repo.find_by_id("111111")
  end

  def test_it_can_find_by_price
    assert_instance_of Array, @repo.find_by_price(14900)
    assert_instance_of Item,  @repo.find_by_price(14900)[0]
    assert_instance_of BigDecimal, @repo.find_by_price(14900)[0].unit_price
    assert_instance_of Item,  @repo.find_by_price(14900)[-1]
  end


  def test_it_can_find_by_name
  	assert_equal "263399475", @repo.find_by_name("Ironstone Pitcher (Small)").id
  end

  def test_it_can_find_by_description
  	data_set = @repo.find_all_with_description("Size 3m")

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
end
