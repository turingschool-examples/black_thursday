require './test/test_helper'

class ItemRepositoryTest < Minitest::Test

  def test_all
    items = @engine.items.all.count
    assert_equal 7, items
  end

  def test_find_by_id
    item = @engine.items.find_by_id(263410021)
    assert_equal "I Love You to the Moon and Back", item.name
  end

  def test_find_by_id_invalid
    item = @engine.items.find_by_id(57394593)
    assert_equal nil, item
  end

  def test_find_by_name
    item = @engine.items.find_by_name("I Love You to the Moon and Back")
    assert_equal "I Love You to the Moon and Back", item.name
  end

  def test_find_by_name_nil
    item = @engine.items.find_by_name("Lane")
    assert_equal nil, item
  end

  def test_find_all_with_description_multiple
    item_array = @engine.items.find_all_with_description("zipper")
    result = item_array.map {|item| item.name}
    assert_equal ['Vogue Paris Original Givenchy 2307', "French bulldog cushion cover 45x45cm *cover only, pad NOT included*"], result
  end

  def test_find_all_with_description_singular
    item_array = @engine.items.find_all_with_description("bicycle")
    result = item_array.map {|item| item.name}
    assert_equal ['Custom Hand Made Miniature Bicycle'], result
  end

  def test_find_all_with_description_empty
    item = @engine.items.find_all_with_description("Phat")
    assert_equal [], item
  end

  def test_all_by_price
    item_array = @engine.items.find_all_by_price(29.99)
    result = item_array.map {|item| item.id}
    assert_equal [263396209], result
  end

  def test_all_by_price_multiple
    item_array = @engine.items.find_all_by_price(9.99)
    result = item_array.map {|item| item.id}
    assert_equal [263500440, 263501394], result

  end

  def test_all_by_price_empty
    item = @engine.items.find_all_by_price(0.50)
    assert_equal [], item
  end

  def test_view_all_prices
    item_array = @engine.items.find_all_by_price_in_range(0..1030)
    result = item_array.map {|item| item.unit_price_to_dollars}
    assert_equal [29.99, 9.99, 9.99, 15.0, 150.0, 20.0, 14.0], result
  end

  def test_all_by_price_in_range
    item_array = @engine.items.find_all_by_price_in_range(10..19)
    result = item_array.map {|item| item.id}
    assert_equal [263410021, 263500620], result
  end

  def test_all_by_price_in_range_false
    item_array = @engine.items.find_all_by_price_in_range(0..8)
    result = item_array.map {|item| item.id}
    assert_equal [], result
  end

  def test_find_all_by_merchant_id_single
    item_array = @engine.items.find_all_by_merchant_id(12334113)
    result = item_array.map {|item| item.name}
    assert_equal ['Custom Hand Made Miniature Bicycle'], result
  end

  def test_find_all_by_merchant_id_multiple
    item_array = @engine.items.find_all_by_merchant_id(12334105)
    result = item_array.map {|item| item.id}
    assert_equal [263396209, 263500440, 263501394], result
  end

  def test_find_all_by_merchant_id_nil
    item_array = @engine.items.find_all_by_merchant_id(371948390)
    result = item_array.map {|item| item.id}
    assert_equal [], result
  end

  def test_it_has_an_inspect
    assert @engine.items.inspect
  end

end
