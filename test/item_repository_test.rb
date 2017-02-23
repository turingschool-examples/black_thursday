require_relative 'test_helper.rb'
require_relative '../lib/item_repository'

class ItemRepositoryTest < Minitest::Test
  attr_reader :ir
  
  def setup 
    @ir = ItemRepository.new("./test/fixtures/temp_items.csv")
  end
  
  def test_it_exists
    assert_instance_of ItemRepository, ir
  end

  def test_it_creates_new_instances_of_merchant
    assert_instance_of Item, ir.all.first
    assert_equal "510+ RealPush Icon Set", ir.all.first.name
  end

  def test_it_returns_all_instances_of_merchant
    assert_equal 3, ir.all.count
  end

  def test_it_can_find_by_id
    assert_instance_of Item, ir.find_by_id("263395237")
    assert_equal "510+ RealPush Icon Set", ir.find_by_id("263395237").name
  end

  def test_it_returns_nil_if_it_does_not_find_id_number
    assert_nil ir.find_by_id("26339523799933")
  end

  def test_it_can_find_by_name
    assert_instance_of Item, ir.find_by_name("510+ RealPush Icon Set")
    assert_equal "263395237", ir.find_by_name("510+ RealPush Icon Set").id
  end

  def test_it_knows_name_case_insensitive
    assert_equal "263395237", ir.find_by_name("510+ realPush icon Set").id
  end

  def test_it_returns_nil_if_it_does_not_find_name
    assert_nil ir.find_by_name("target")
  end
  
  def test_it_can_find_all_descriptions_that_match_supplied_fragment
    assert_instance_of Item, ir.find_all_by_description("original UI").first
    assert_equal 2, ir.find_all_by_description("colour").count
    assert_equal "263395617", ir.find_all_by_description("colour").first.id
  end
  
  def test_find_by_description_is_case_insensitive
    assert_equal "263395617", ir.find_all_by_description("COlour").first.id
  end
  
  def test_find_by_description_returns_empty_array_if_no_matches
    skip
    assert_equal [], ir.find_all_by_description("rrrrrrrr")
  end
  
  def test_it_returns_instance_of_item_when_supplied_with_price
    skip
    assert_instance_of Item, ir.find_all_by_price
  end
  
  def test_find_by_price_returns_empty_array_if_no_matches
    skip
    assert_equal [], ir.find_all_by_price("rrrrrrrr")
  end
  
  def test_it_finds_all_in_price_range
    skip
  end
  
  def test_find_all_in_price_range_returns_empty_array_if_no_matches
    skip
    assert_equal [], ir.find_all_in_price_range("rrrrrrrr")
  end
  
  def test_it_finds_one_by_merchant_id
    assert_instance_of Item, ir.find_all_by_merchant_id("12334141").first
    assert_equal "510+ RealPush Icon Set", ir.find_all_by_merchant_id("12334141").first.name
  end
  
  def test_it_finds_all_by_merchant_id
    assert_instance_of Item, ir.find_all_by_merchant_id("12334185").first
    assert_equal 2, ir.find_all_by_merchant_id("12334185").count
    assert_equal "Glitter scrabble frames", ir.find_all_by_merchant_id("12334185").first.name
  end
  
  def test_it_returns_empty_array_when_merchant_id_not_found
    skip
    assert_equal [], ir.find_all_by_merchant_id("rrrrrrrr")
  end
  
  
end