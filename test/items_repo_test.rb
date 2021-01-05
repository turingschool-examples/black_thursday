require 'CSV'
require './test/test_helper'

class ItemsRepoTest < Minitest::Test

  def setup
    @repo = ItemsRepo.new("./data/items.csv")
  end

  def test_it_is
    assert_instance_of ItemsRepo, @repo
  end

  def test_it_has_attributes
    assert_instance_of Array , @repo.items
  end

  def test_it_can_gather_all_items
    assert_instance_of Item, @repo.all[0]
    assert_instance_of Item, @repo.all[-1]
    assert_equal 1367, @repo.all.length
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
end
