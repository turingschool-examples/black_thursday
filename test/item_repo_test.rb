require_relative 'test_helper'
require_relative '../lib/item_repo'
require_relative '../lib/sales_engine'
require_relative '../lib/merchant_repo'

class ItemRepositoryTest < Minitest::Test
  attr_reader :item_repo

  def set_up
    files = ({:invoices => "./test/fixtures/invoice_fixture.csv", :items => "./test/fixtures/item_fixture.csv", :merchants => "./test/fixtures/merchant_fixture.csv"})
    SalesEngine.from_csv(files).items
  end

  def test_item_exists
    assert_instance_of ItemRepository, set_up
  end

  def test_all
    assert_equal 5, set_up.items.count
  end

  def test_find_by_exisiting_id
    assert_instance_of Item, set_up.find_by_id(263395237)
  end

  def test_find_by_id_nil
    assert_nil set_up.find_by_id(263395230)
  end

  def test_find_by_name_nil
    assert_nil set_up.find_by_name("Kool-Aid")
  end

  def test_find_by_name_exists
    assert_instance_of Item, set_up.find_by_name('Disney scrabble frames')
  end

  def test_find_by_all_with_description_word_exists
    assert_equal 2, set_up.find_all_with_description("he").count
  end

  def test_find_by_all_with_description_word_empty_array
    assert_equal [], set_up.find_all_with_description("supercalifragilistic")
  end

  def test_find_by_all_by_price_empty_array
    assert_equal [], set_up.find_all_by_price(5.00)
  end

  def test_find_by_all_by_existing_price
    assert_equal 1, set_up.find_all_by_price(12.00).count
  end

  def test_find_by_all_by_price_range_price_exists_in_range
    assert_equal 3, set_up.find_all_by_price_in_range(10.00..15.00).count
  end

  def test_find_by_all_by_price_range_empty_array
    assert_equal [], set_up.find_all_by_price_in_range(1.00..5.00)
  end

  def test_find_by_all_by_merchant_id_empty_array
    assert_equal [], set_up.find_all_by_merchant_id("3")
  end

  def test_find_by_all_by_merchant_id_exists
    assert_equal 1, set_up.find_all_by_merchant_id(12334141).count
  end

end
