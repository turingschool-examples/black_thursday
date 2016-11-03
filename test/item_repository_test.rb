require_relative '../test/test_helper'
require_relative '../lib/item_repository'
require_relative '../lib/sales_engine'


class ItemRepositoryTest < Minitest::Test
  attr_reader :item_repository
  def setup
    se = SalesEngine.from_csv({
              :items     => 'data/item_fixture.csv',
              :merchants => 'data/merchants_fixture.csv',})
    @item_repository = se.items
  end

  def test_it_exists
    assert item_repository
  end

  def test_it_reads_a_csv_file
    output = item_repository.csv
    assert output
  end

  def test_it_saves_everything_as_a_giant_array
    output = item_repository.all
    assert_equal Array, output.class
  end

  def test_all
    output = item_repository.all.count
    assert_equal 1, output
  end

  def test_it_puts_the_id_in_the_all_array
    output = item_repository.all[0].id
    assert_equal 263400121, output
  end

  def test_it_puts_the_name_in_the_all_array
    output = item_repository.all[0].name
    assert_equal "Custom Hand Made Miniature Bicycle", output
  end

  def test_it_puts_the_merchant_id_in_the_all_array
    output = item_repository.all[0].merchant_id
    assert_equal 12334113, output
  end

  def test_it_puts_the_unit_price_in_the_all_array
    output = item_repository.all[0].unit_price
    assert_equal 150.0, output
  end

  def test_find_by_id_finds_proper_values
    item_repository.all
    output = item_repository.find_by_id(263400121).name
    assert_equal "Custom Hand Made Miniature Bicycle", output
  end

  def test_find_by_id_can_be_used_to_retrieve_price_in_right_class
    item_repository.all
    output = item_repository.find_by_id(263400121).unit_price
    assert_equal BigDecimal, output.class
  end

  def test_find_by_id_can_retrieve_unit_price
    item_repository.all
    output = item_repository.find_by_id(263400121).unit_price
    assert_equal 150.0, output
  end

  def test_find_by_id_works_with_proper_format
    item_repository.all
    output = item_repository.find_by_id(263400121)
    assert_equal Item, output.class
  end

  def test_find_by_id_returns_nil_with_no_input
    item_repository.all
    output = item_repository.find_by_id(nil)
    assert_equal nil, output
  end

  def test_find_by_name_returns_proper_phrase_with_nil_input
    item_repository.all
    output = item_repository.find_by_name(nil)
    assert_equal "A cool spindle", output
  end

  def test_find_by_name_works_with_proper_format
    item_repository.all
    output = item_repository.find_by_name("CustoM Hand MadE MiniaTure BicyCle")
    assert_equal Item, output.class
    assert_equal 263400121, output.id
    assert_equal 12334113, output.merchant_id
    assert_equal 150.0, output.unit_price
  end

  def test_find_all_with_description
    item_repository.all
    output = item_repository.find_all_with_description("bicycle/mtb")
    assert_equal 263400121, output.first.id
    assert_equal 12334113, output.first.merchant_id
    assert_equal 150.0, output.first.unit_price
    assert_equal "Custom Hand Made Miniature Bicycle", output.first.name
  end

  def test_find_all_by_price
    item_repository.all
    output = item_repository.find_all_by_price(150.0)
    assert_equal Array, output.class
    assert_equal 263400121, output.first.id
    assert_equal 12334113, output.first.merchant_id
  end

  def test_find_all_by_price_range
    item_repository.all
    output = item_repository.find_all_by_price_in_range(100.0..200.0)
    assert_equal Array, output.class
    assert_equal 263400121, output.first.id
  end

  def test_find_by_merchant_id
    item_repository.all
    output = item_repository.find_all_by_merchant_id(12334113)
    assert_equal Array, output.class
    assert_equal 263400121, output.first.id
    assert_equal "Custom Hand Made Miniature Bicycle", output.first.name
    assert_equal 150.0, output.first.unit_price
  end
end
