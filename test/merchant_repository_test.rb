require_relative 'test_helper'
require_relative '../lib/merchant_repository'
require_relative '../lib/sales_engine'

class MerchantRepositoryTest < Minitest::Test

  def setup
    se = SalesEngine.from_csv({
      :items     => "./test/fixtures/items_fixture.csv",
      :merchants => "./test/fixtures/merchants_fixture.csv",
    })
    @mr = se.merchants
  end

  def test_it_exists
    assert_instance_of MerchantRepository, @mr
  end

  def test_it_can_parse_data
    assert @mr.merchants.length > 0
  end

  def test_it_has_the_correct_first_entry_id
    assert_equal 12334105, @mr.merchants[0].id
  end

  def test_it_has_the_correct_first_entry_name
    assert_equal "Shopin1901", @mr.merchants[0].name
  end

  def test_all_returns_all_the_merchants
    assert_equal 21, @mr.all.count
  end

  def test_it_can_find_a_merchant_using_id
    id_1 = 12334174
    id_2 = "1"
    id_3 = 101

    assert_equal 12334174, @mr.find_by_id(id_1).id
    assert_nil @mr.find_by_id(id_2)
    assert_nil @mr.find_by_id(id_3)
  end

  def test_it_can_find_a_merchant_using_name
    name_1 = "GoldenRayPress"
    name_2 = "goldenRaypress"
    name_3 = ""
    name_4 = "hi"

    assert_equal "GoldenRayPress" ,@mr.find_by_name(name_1).name
    assert_equal  "GoldenRayPress",@mr.find_by_name(name_2).name
    assert_nil @mr.find_by_name(name_3)
    assert_nil @mr.find_by_name(name_4)
  end

  def test_it_can_find_all_merchants_with_a_given_name
    name_1 = "in"
    name_2 = "Turing School of Software"
    name_3 = "Mo"

    assert_equal 4, @mr.find_all_by_name(name_1).length
    assert_equal [], @mr.find_all_by_name(name_2)
    assert_equal 3, @mr.find_all_by_name(name_3).length
  end

  def test_repository_has_reference_to_sales_engine
    assert @mr.sales_engine
  end

end
