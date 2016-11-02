require_relative 'test_helper'
require_relative '../lib/item_repo'

class ItemRepoTest < Minitest::Test
  def test_item_repo_class_exists
    assert_instance_of ItemRepo, ItemRepo.new
  end

  def test_item_repo_can_load_all_items
    item_repo = ItemRepo.new
    assert_equal Item, item_repo.all.first.class
    assert_equal 263395617, item_repo.all[1].id
    assert_equal "Glitter scrabble frames", item_repo.all[1].name
    assert_equal "Glitter scrabble frames \n\nAny colour glitter \nAny wording\n\nAvailable colour scrabble tiles\nPink\nBlue\nBlack\nWooden", item_repo.all[1].description
    assert_equal 13.00, item_repo.all[1].unit_price
    assert_equal "2016-01-11 11:51:37 UTC", item_repo.all[1].created_at
    assert_equal "1993-09-29 11:56:40 UTC", item_repo.all[1].updated_at
    assert_equal 12334185, item_repo.all[1].merchant_id
  end

  def test_item_repo_can_find_by_id
    item_repo = ItemRepo.new.find_by_id(263395617)
    assert_equal 263395617, item_repo.id
  end

  def test_item_repo_can_find_by_name
    item_repo = ItemRepo.new.find_by_name("Glitter scrabble frames")
    assert_equal "Glitter scrabble frames", item_repo.name
  end

  def test_item_repo_can_find_all_with_description
    item_repo = ItemRepo.new.find_all_with_description("chocolate").to_s
    assert item_repo.include?("8, real sheepskin uggs.\\nZipper detail.\\nOnly worn twice.\\nChocolate brown color")
    assert item_repo.include?("The Coconut imparts an almost chocolatey flavor into the honey")
  end

  def test_item_repo_can_find_all_by_price
    assert_equal [], ItemRepo.new.find_all_by_price(132)
    assert_equal 6, ItemRepo.new.find_all_by_price(34.00).count
    assert_equal 5, ItemRepo.new.find_all_by_price(24.00).count
  end

  def test_item_repo_can_find_all_by_price_ion_range
    assert_equal [], ItemRepo.new.find_all_by_price_in_range((100000000..200000000))
    assert_equal 59, ItemRepo.new.find_all_by_price_in_range((2.50..4.50)).count
  end

  def test_item_repo_can_find_all_by_merchant_id
    assert_equal [], ItemRepo.new.find_all_by_merchant_id(77777777)
    assert_equal 2, ItemRepo.new.find_all_by_merchant_id(12334271).count
  end
end
