require 'minitest/autorun'
require 'minitest/pride'
require './lib/item_repo'

class ItemRepoTest < Minitest::Test

  def test_it_has_a_class
    i = ItemRepo.new
    assert_equal ItemRepo, i.class
  end

  def test_it_can_display_all_items
    i = ItemRepo.new
    i.set_up("./data/items.csv")
    assert i.all
  end

  def test_it_can_search_by_id
    i = ItemRepo.new
    i.set_up("./data/items.csv")
    assert_equal ["Hot Green Dragon..."], i.find_by_id(263398227)
  end

  def test_it_can_find_by_name
  end

  def test_it_can_can_find_by_description
  end

  def test_it_can_find_by_price
  end

  def test_it_can_find_by_price_in_range
  end

  def test_it_can_find_by_merchant_id
  end

end
