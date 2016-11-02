require 'minitest/autorun'
require 'minitest/pride'
require './lib/item_repo'

class ItemRepoTest < Minitest::Test

  def test_it_has_a_class
    i = ItemRepo.new
    assert_equal ItemRepo, i.class
  end

  # def test_itemrepo_can_call_parent
  #   parent = Minitest::Mock.new
  #   item_repo = ItemRepo.new(data, parent)
  #   parent.expect (:method_here, nil, [1])
  #   item_repo.exists?
  #   parent.verify
  # end

  def test_it_can_display_all_items
    i = ItemRepo.new
    i.parse_file("./data/items.csv")
    assert i.all
  end

  def test_it_can_search_by_id
    i = ItemRepo.new
    i.parse_file("./data/items.csv")
    assert_equal "HOT Dragon Head Turtle Hand Blown Glass Art Figurine Money Lucky Good Collect", i.find_by_id(263398227).name
  end

  def test_it_can_find_by_name
    i = ItemRepo.new
    i.parse_file("./data/items.csv")
    name = "HOT Dragon Head Turtle Hand Blown Glass Art Figurine Money Lucky Good Collect"
    assert_equal 263395237,i.find_by_name(name)
  end

  def test_it_can_can_find_by_description
    i = ItemRepo.new
    i.parse_file("./data/items.csv")
    description = "- Super Chunky knit infinity scarf
- Soft mixture of 97% Acrylic and 3% Viscose
- Beautiful, Warm, and Stylish
- Very easy to care for

Hand wash with cold water and lay flat to dry"
    assert_equal [], i.find_all_with_description(description)
  end

  def test_it_can_find_by_price
    i = ItemRepo.new
    i.parse_file("./data/items.csv")
    item = "510+ RealPush Icon Set"
    assert_equal item, i.find_all_by_price(3800)
    #not sure if this is the only item or it doesn't return array because method is not well set
  end

  def test_it_can_find_by_price_in_range
    i = ItemRepo.new
    i.parse_file("./data/items.csv")
    item = "510+ RealPush Icon Set"
    assert_equal item, i.find_all_by_price_in_range(3790, 3810)
  end

  def test_it_can_find_by_merchant_id
    i = ItemRepo.new
    i.parse_file("./data/items.csv")
    item = "510+ RealPush Icon Set"
    assert_equal item, i.find_all_by_merchant_id("12334871")
  end

end
