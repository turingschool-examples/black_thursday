require_relative 'test_helper'
require './lib/sales_engine'
require './lib/merchant_repository'

class MerchantRepositoryTest < Minitest::Test

  def setup
    @se = SalesEngine.new({
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv",
      })
  end

  def test_it_exists
    assert_instance_of MerchantRepository, @se.merchants
  end

  def test_it_returns_an_array_of_all_merchant_instances

    assert_equal 475, @se.merchants.all.count
  end

  def test_it_finds_merchant_by_id_or_nil
    merchant = @se.merchants.find_by_id(12335971)

    assert_equal 12335971, merchant.id
    assert_equal "ivegreenleaves", merchant.name

    assert_nil @se.merchants.find_by_id(2)
  end

  def test_it_finds_the_first_matching_merchant_by_name_case_insensitive
    merchant_1 = @se.merchants.find_by_name("leaburrot")
    merchant_2 = @se.merchants.find_by_name("LEABURROT")
    merchant_3 = @se.merchants.find_by_name("Turing School of Software and Design")


    assert_equal 12334411, merchant_1.id
    assert_equal 12334411, merchant_2.id
    assert_nil merchant_3
  end

  def test_it_finds_all_merchants_matching_given_fragment
    expected_1 = @se.merchants.find_all_by_name("style")
    expected_2 = @se.merchants.find_all_by_name("Turing School of Software and Design")

    assert_equal 3, expected_1.length
    assert expected_1.map(&:name).include?("justMstyle")
    assert expected_1.map(&:id).include?(12337211)
    assert_equal [], expected_2
  end

  def test_creates_a_new_merchant_instance
    attributes = {name: "Turing School of Software and Design"}
    @se.merchants.create(attributes)
    merchant = @se.merchants.find_by_id(12337412)
    expected = "Turing School of Software and Design"

    assert_equal expected, merchant.name
  end

  def test_it_updates_a_merchant
    attributes = {name: "Turing School of Software and Design"}
    @se.merchants.create(attributes)

    attributes = {name: "TSSD"}
    @se.merchants.update(12337412, attributes)
    merchant = @se.merchants.find_by_id(12337412)
    expected = "TSSD"

    assert_equal expected, merchant.name
    assert_nil @se.merchants.find_by_name("Turing School of Software and Design")
  end

  def test_it_can_not_update_id
    attributes = {name: "Turing School of Software and Design"}
    @se.merchants.create(attributes)

    attributes = {name: "TSSD"}
    @se.merchants.update(12337412, attributes)

    attributes = {id: 13000000}
    @se.merchants.update(12337412, attributes)

    assert_nil @se.merchants.find_by_id(13000000)
    assert_nil @se.merchants.update(13000000, {})
  end

  def test_delete_deletes_specific_merchant
    attributes = {name: "Turing School of Software and Design"}
    @se.merchants.create(attributes)

    @se.merchants.delete(12337412)
    merchant = @se.merchants.find_by_id(12337412)
    assert_nil merchant

    assert_nil @se.merchants.delete(12337412)
  end

  def test_it_can_return_merchant_id
    assert 12334105, @se.merchants.all.first.id
  end

  def test_it_can_return_merchant_name
    assert_equal "Shopin1901", @se.merchants.all.first.name
    assert_equal "CJsDecor", @se.merchants.all.last.name
  end
end
