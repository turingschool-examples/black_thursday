require_relative 'test_helper'
require_relative '../lib/item_repository'

class ItemRepositoryTest < Minitest::Test
  attr_reader :repo, :parent
  def setup
    @parent = Minitest::Mock.new
    @repo = ItemRepository.new('./test/assets/small_items.csv', parent)
  end

  def test_it_finds_by_id
      assert_equal "Free standing Woden letters", repo.find_by_id(263396013).name
  end

  def test_it_returns_nil_when_id_not_present
      assert_equal nil, repo.find_by_id(45)
  end

  def test_it_finds_by_name_when_present
      assert_equal 263396013, repo.find_by_name("Free standing Woden letters").id
  end

  def test_it_finds_by_name_case_insensitive
    assert_equal 263396013, repo.find_by_name("Free standing woden letters").id
  end

  def test_it_returns_nil_when_name_not_present
    assert_equal nil, repo.find_by_name("Hello")
  end

  def test_it_returns_empty_array_when_description_not_present
      assert_equal [], repo.find_all_with_description("Boogers")
  end

  def test_it_returns_array_when_description_unique_case_insensitive
    current = repo.find_all_with_description("socialMedia")
    assert_equal 263395237, current[0].id
  end

  def test_it_returns_array_when_description
    current = repo.find_all_with_description("glitter")
    assert_equal 263395617, current[0].id
  end

  def test_it_converts_big_decimal_to_dollar
    assert_equal 12.00, repo.convert_to_dollar(1200)
  end

  def test_it_finds_item_by_exact_price
    current = repo.find_all_by_price(BigDecimal.new(13))
    assert_equal "Glitter scrabble frames", current[0].name
  end

  def test_it_returns_empty_array_when_no_prices_match
    assert_equal [], repo.find_all_by_price(BigDecimal.new(20))
  end

  def test_it_returns_array_of_price_in_range
    current = repo.find_all_by_price_in_range(10.00..13.00)
    assert_equal 263395237, current[0].id
  end
  
  def test_it_returns_array_of_price_in_different_range
    current = repo.find_all_by_price_in_range(10.00..14.00)
    assert_equal "Glitter scrabble frames", current[1].name
  end

  def test_it_returns_empty_array_if_no_price_in_range
    assert_equal [], repo.find_all_by_price_in_range(94.00..95.00)
  end
  
  def test_it_returns_array_of_items_that_have_matching_merchant_id
    current = repo.find_all_by_merchant_id(12334141)
    assert_equal 263395237, current[0].id
  end
  
  def test_it_returns_array_of_items_that_have_different_matching_merchant_id
    current = repo.find_all_by_merchant_id(12334185)
    assert_equal "Glitter scrabble frames", current[0].name
  end

  def test_it_returns_empty_array_if_items_have_merchant_id
    assert_equal [], repo.find_all_by_merchant_id(45)
  end

  def test_it_calls_parent_find_merchant_by_item_id
    parent.expect(:find_merchant_by_merchant_id, nil, [1])
    repo.find_merchant_by_merchant_id(1)
    parent.verify
  end

  def test_that_parse_items_parses_items
    current = repo.parse_items_csv('./test/assets/small_items.csv')
    assert_equal 10, current.count
  end

end

