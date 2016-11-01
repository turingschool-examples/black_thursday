require './lib/test_helper'
require './lib/item_repository'

class ItemRepositoryTest < Minitest::test_helper

  def setup 
    @repo = ItemRepository.new([Item.new({
                                          :id => 263395237, 
                                          :name => "510+ RealPush Icon Set", 
                                          :description => HTMLEntities.new.decode("You&#39;ve got a total socialmedia iconset! Almost every social icon on the planet earth."), 
                                          :unit_price => BigDecimal.new(1200), 
                                          :merchant_id => 12334141, 
                                          :created_at => Time.utc(2016, 1, 11, 9, 34, 06), 
                                          :updated_at => Time.utc(2007, 6, 4, 21, 35, 10)
                                          }),
                                Item.new({:id => 263395617, 
                                          :name => "Glitter scrabble frames", 
                                          :description => HTMLEntities.new.decode("Disney glitter frames Any colour glitter available and can do any characters you require Different colour scrabble tiles Blue Black Pink Wooden"), 
                                          :unit_price => BigDecimal.new(1350), 
                                          :merchant_id => 12334185, 
                                          :created_at => Time.utc(2016, 01, 11, 11, 51, 37), 
                                          :updated_at => Time.utc(2008, 04, 02, 13, 48, 57)
                                          }),
                                Item.new({:id => 263396013, 
                                          :name => "Free standing Woden letters", 
                                          :description => HTMLEntities.new.decode("Disney glitter Free standing wooden letters 15cm Any colours"), 
                                          :unit_price => BigDecimal.new(700), 
                                          :merchant_id => 12334185, 
                                          :created_at => Time.utc(2016, 0, 11, 11, 51, 36), 
                                          :updated_at => Time.utc(2001, 09, 17, 15, 28, 43)
                                          })
                                ])
  end

  def test_it_finds_by_id
    assert_equal "Free standing Woden letters", repo.find_by_id(263395721).name
  end

  def test_it_returns_nil_when_id_not_present
    assert_equal nil, repo.find_by_id(45)
  end

  def test_it_finds_by_name_when_present
    assert_equal 263395721, repo.find_by_name("Free standing Woden letters").id
  end

  def test_it_returns_nil_when_name_not_present
    assert_equal nil, repo.find_by_name("Hello")
  end

  def test_it_returns_empty_array_when_description_not_present
    assert_equal [], repo.find_all_by_description("Boogers")
  end

  def test_it_returns_array_when_description
    assert_equal "Free standing Woden letters", repo.find_all_by_description("Disney glitter")[0].name
  end

  def test_it_finds_item_by_exact_price
    assert_equal "Free standing Woden letters", repo.find_all_by_price(13.50)
  end

  def test_it_returns_empty_array_when_no_prices_match
    assert_equal [], repo.find_all_by_price(20.00)
  end

  def test_it_returns_array_of_price_in_range
    assert_equal "Free standing Woden letters", repo.find_all_by_price(10.00..14.00)[1].name
  end

  def test_it_returns_empty_array_if_no_price_in_range
    assert_equal [], repo.find_all_by_price(14.00..15.00)
  end

  def test_it_returns_array_of_items_that_have_matching_merchant_id
    assert_equal "Disney scrabble frames", repo.find_all_by_merchant_id(12334185)[0].name
  end

  def test_it_returns_empty_array_if_items_have_merchant_id
    assert_equal [], repo.find_all_by_merchant_id(45)
  end

end

