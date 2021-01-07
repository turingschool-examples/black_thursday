require './test/test_helper'

class MerchantRepositoryTest < Minitest::Test

  def setup
    merchant_path = "./data/merchants.csv"
    arguments = merchant_path
    #parent = mock("parent")
    @mr = MerchantRepository.new(arguments) #parent)
  end

  def test_it_exists_and_has_attributes
    assert_instance_of MerchantRepository, @mr
    assert_equal 475, @mr.merchants.length
  end

  def test_it_can_return_all_merchants
    assert_equal 475, @mr.all.count
  end

  def test_it_can_find_merchants_by_id
    id = 12335971
    expected = @mr.find_by_id(id)

    assert_equal 12335971, expected.id
    assert_equal "ivegreenleaves", expected.name
  end

  def test_it_returns_nil_if_no_merchant
    id = 101
    expected = @mr.find_by_id(id)

    assert_nil expected
  end

  def test_it_can_find_merchants_by_name
    name = "leaburrot"
    expected = @mr.find_by_name(name)

    assert_equal 12334411, expected.id
    assert_equal name, expected.name
  end

  def test_it_can_find_merchants_by_CAPITAlIZED_name
    name = "LEABURROT"
    expected = @mr.find_by_name(name)

    assert_equal 12334411, expected.id
    assert_equal name.downcase, expected.name
  end

  def test_it_can_return_nil_if_no_name_exists
    name = "Turing School of Software and Design"
    expected = @mr.find_by_name(name)

    assert_nil expected
  end

  def test_it_can_find__all_merchants_by_name
    fragment = "style"
    expected = @mr.find_all_by_name(fragment)

    assert_equal 3, expected.length
    assert_equal true, expected.map(&:name).include?("justMstyle")
    assert_equal true, expected.map(&:id).include?(12337211)
  end

  def test_find_all_by_name_returns_empty_array_if_no_names
    name = "Turing School of Software and Design"
    expected = @mr.find_all_by_name(name)

    assert_equal [], expected
  end

  def test_highest_merchant_id_plus_one
    assert_equal 12337412, @mr.highest_merchant_id_plus_one
  end

  def test_it_can_create_new_merchants
    attributes = {name: "Turing School of Software and Design"}
    @mr.create(attributes)
    expected = @mr.find_by_id(12337412)

    assert_equal expected.name, "Turing School of Software and Design"
  end

  def test_it_can_update_name_of_merchant
    attributes = {name: "Turing School of Software and Design"}
    @mr.create(attributes)
    attributes = {name: "TSSD"}
    @mr.update(12337412, attributes)
    expected = @mr.find_by_id(12337412)

    assert_equal "TSSD", expected.name

    expected = @mr.find_by_name("Turing School of Software and Design")

    assert_nil expected
  end

  def test_update_can_only_update_name_and_not_id
    attributes = {id: 13000000}
    @mr.update(12337412, attributes)
    expected = @mr.find_by_id(13000000)

    assert_nil expected
  end

  def test_it_cant_update_unknown_merchant
    expected = @mr.update(13000000, {})

    assert_nil expected
  end

  def test_it_can_delete_merchants
    @mr.delete(12337412)
    expected = @mr.find_by_id(12337412)

    assert_nil expected
  end

  def test_deleting_unknown_merchant_does_nothing
    expected = @mr.delete(12337412)

    assert_nil expected
  end
end
