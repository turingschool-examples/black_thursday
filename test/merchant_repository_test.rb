require_relative 'test_helper.rb'
require './lib/sales_engine'
require './lib/merchant_repository'
require 'pry'

class MerchantRepositoryTest < Minitest::Test
  def setup
    merchant_info = {:merchants => "./data/merchants.csv"}
    se = SalesEngine.from_csv(merchant_info)
    @mr = se.merchants
  end

  def test_it_exists
    assert_instance_of(MerchantRepository, @mr)
  end

  def test_it_creates_merchant_list
    assert_equal "Shopin1901", @mr.merchants[0].name
  end

  def test_all_returns_array_of_all_merchants
    assert_equal 475, @mr.all.length
  end

  def test_it_finds_merchant_by_ID
    id = 12335971
    expected = @mr.find_by_id(id)
    assert_equal 12335971, expected.id
    assert_equal "ivegreenleaves", expected.name
  end

  def test_it_returns_nil_if_no_ID
    id = 13
    expected = @mr.find_by_id(id)
    assert_nil expected
  end

  def test_it_finds_by_name
    name = "leaburrot"
    expected = @mr.find_by_name(name)
    assert_equal 12334411, expected.id
    assert_equal name, expected.name
  end

  def test_find_by_name_returns_nil
    name = "le"
    expected = @mr.find_by_name(name)
    assert_nil expected
  end

  def test_find_by_name_case_insensitive
    name = "LEABURROT"
    expected = @mr.find_by_name(name)
    assert_equal 12334411, expected.id
  end

  def test_it_finds_all_by_name
    fragment = "style"
    expected = @mr.find_all_by_name(fragment)
    assert_equal 3, expected.length
    assert expected.map(&:name).include?("justMstyle")
    assert expected.map(&:id).include?(12337211)
  end

  def test_find_all_returns_empty_array
    name = "Turing School of Software and Design"
    expected = @mr.find_all_by_name(name)
    assert_equal [], expected
  end

  def test_it_can_generate_new_id
    expected = @mr.generate_id_for_new_merchant
    assert_equal 12337412, expected
  end

  def test_it_can_create_merchant
    attributes = {name: "Turing School of Software and Design"}
    @mr.create(attributes)
    expected = @mr.find_by_id(12337412)
    assert_equal "Turing School of Software and Design", expected.name
  end

  def test_it_can_update_name
    attributes = {name: "Turing School of Software and Design"}
    @mr.create(attributes)
    attributes = {
      name: "TSSD"
    }
    @mr.update(12337412, attributes)
    expected = @mr.find_by_id(12337412)
    assert_equal "TSSD", expected.name
    expected = @mr.find_by_name("Turing School of Software and Design")
    assert_nil expected
  end

  def test_it_can_not_update_IDs
    attributes = {name: "Turing School of Software and Design"}
    @mr.create(attributes)
    attributes = {
      id: 13000000
    }
    @mr.update(12337412, attributes)
    expected = @mr.find_by_id(13000000)
    assert_nil expected
  end

  def test_update_does_not_work_on_unknown_merchant
    @mr.update(13000000, {})
    expected = @mr.find_by_id(13000000)
    assert_nil expected
  end

  def test_it_can_delete_merchant
    @mr.delete(12337411)
    expected = @mr.find_by_id(12337411)
    assert_nil expected
  end
end
