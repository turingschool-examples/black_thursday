require 'simplecov'
SimpleCov.start
require 'minitest/autorun'
require 'minitest/pride'
require './lib/merchant_repository'

class MerchantRepositoryTest < Minitest::Test

  def test_that_it_exists
    se = SalesEngine.from_csv({
    :items     => "./data/items.csv",
    :merchants => "./data/merchants.csv",
    })

    mr = se.merchants
    assert_instance_of MerchantRepository, mr
  end

  def test_that_it_loads_the_repository_of_merchants
    se = SalesEngine.from_csv({
    :items     => "./data/items.csv",
    :merchants => "./data/merchants.csv",
    })

    mr = se.merchants
    actual = mr.merchants_array[0]

    assert_instance_of Merchant , actual
  end

  def test_the_all_method_returns_an_array_of__all_instances_of_merchant
    se = SalesEngine.from_csv({
    :items     => "./data/items.csv",
    :merchants => "./data/merchants.csv",
    })

    mr = se.merchants
    assert_equal 475, mr.all.count
  end

  def test_the_find_by_id_method_finds_merchants_by_id
    se = SalesEngine.from_csv({
    :items     => "./data/items.csv",
    :merchants => "./data/merchants.csv",
    })

    mr = se.merchants
    findings = mr.find_by_id(12334176)
    actual = findings[0].name
    assert_equal 'thepurplepenshop', actual
  end

  def test_the_find_by_name_method_finds_merchants_by_name
    se = SalesEngine.from_csv({
    :items     => "./data/items.csv",
    :merchants => "./data/merchants.csv",
    })

    mr = se.merchants
    findings = mr.find_by_name("CJsDecor")
    actual = findings[0].id
    assert_equal 12337411, actual
  end

  def test_that_the_find_all_method_finds_merchants_by_fragment
    se = SalesEngine.from_csv({
    :items     => "./data/items.csv",
    :merchants => "./data/merchants.csv",
    })

    mr = se.merchants
    actual = mr.find_all_by_name("Ann").count

    assert_equal 2, actual
  end

  def test_that_create_method_creates_new_merchants
    mr = MerchantRepository.new([])

    mr.create("Turing School")
    mr.create("Mcdonalds")
    id_number = mr.merchants_array[1].id
    name = mr.merchants_array[1].name

    assert_equal 2 , id_number
    assert_equal 'Mcdonalds', name
  end

  def test_that_delete_method_deletes_merchants
    mr = MerchantRepository.new([])

    mr.create("Turing School")
    mr.create("Mcdonalds")
    mr.delete(1)
    id_number = mr.merchants_array[0].id
    name = mr.merchants_array[0].name

    assert_equal 2 , id_number
    assert_equal 'Mcdonalds', name
  end

end
