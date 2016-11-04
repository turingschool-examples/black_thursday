require 'simplecov'
SimpleCov.start
require 'minitest/autorun'
require 'minitest/pride'
require './lib/sales_engine'
require 'pry'

class MerchantRepositoryTest < Minitest::Test
  attr_reader   :sales_engine, 
                :repository

  def setup
    @sales_engine = SalesEngine.from_csv({ 
    :items => "./fixture/items.csv", 
    :merchants => "./fixture/merchant_test_file.csv" 
    })
    @repository = sales_engine.merchants
  end

  def test_it_creates_an_array
    assert_equal Array, repository.all.class
  end

  def test_it_has_the_correct_number_of_merchants
    assert_equal 6, repository.all.length
  end

  def test_it_can_find_by_merchant_id
    assert_equal "Shopin1901", repository.find_by_id(102).name
    assert_equal "Candisart", repository.find_by_id(103).name
  end

  def test_returns_nil_if_no_id_match
    refute repository.find_by_id(12345678)
  end

  def test_it_can_find_merchant_by_name
    assert_equal (102), repository.find_by_name("Shopin1901").id
    assert_equal (103), repository.find_by_name("Candisart").id
  end

  def test_returns_nil_if_no_name_match
    refute repository.find_by_name("Amazon")
  end

  def test_it_can_find_merchant_id_by_case_insensitive_name
    assert_equal (102), repository.find_by_name("SHOPIN1901").id
    assert_equal (102), repository.find_by_name("shopin1901").id
    assert_equal (102), repository.find_by_name("sHOPin1901").id
    assert_equal (103), repository.find_by_name("CANDISART").id
    assert_equal (103), repository.find_by_name("candisart").id
    assert_equal (103), repository.find_by_name("CANDisart").id
  end

  def test_it_can_find_all_by_name_returns_an_array
    assert_equal [], repository.find_all_by_name("Amazon")
    assert_equal Array, repository.find_all_by_name("1901").class
  end

  def test_it_can_find_merchants_by_partial_name
    assert_equal 0, repository.find_all_by_name("Amazon").length
    assert_equal 2, repository.find_all_by_name("Shop").length
    assert_equal 1, repository.find_all_by_name("art").length
  end

  def test_it_can_find_merchants_by_case_insensitive_partial_name
    assert_equal 0, repository.find_all_by_name("AMAZON").length
    assert_equal 2, repository.find_all_by_name("shop").length
    assert_equal 2, repository.find_all_by_name("SHOP").length
    assert_equal 2, repository.find_all_by_name("sHOp").length
  end

  def test_that_a_merchant_repo_knows_who_its_parent_is
    assert_equal sales_engine, repository.parent
    assert_instance_of SalesEngine, repository.parent
  end

end
