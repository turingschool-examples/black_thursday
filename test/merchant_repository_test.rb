require_relative 'test_helper'
require_relative '../lib/merchant_repository.rb'

class MerchantRepositoryTest < Minitest::Test
  def setup
    @merchant_repository = MerchantRepository.new("./data/merchants.csv")
  end

  def test_it_exists
    assert_instance_of MerchantRepository, @merchant_repository
  end

  def test_it_can_hold_merchants
    assert_instance_of Array, @merchant_repository.merchants
  end

  def test_its_holding_merchants
    assert_instance_of Merchant, @merchant_repository.merchants[0]
    assert_instance_of Merchant, @merchant_repository.merchants[25]
  end

  def test_it_can_return_merchants_using_all
    assert_instance_of Merchant, @merchant_repository.all[5]
    assert_instance_of Merchant, @merchant_repository.all[97]
  end

  def test_it_can_find_by_id
    expected = @merchant_repository.merchants[0]
    actual = @merchant_repository.find_by_id(12334105)
    assert_equal expected, actual
  end

  def test_it_can_find_by_name
    expected = @merchant_repository.merchants[0]
    actual = @merchant_repository.find_by_name("Shopin1901")
    assert_equal expected, actual
  end

  def test_it_can_find_all_by_name
    expected = 4
    actual = @merchant_repository.find_all_by_name("sas").count
    assert_equal expected, actual
    actual_2 = @merchant_repository.find_all_by_name("SAS").count
    assert_equal expected, actual_2
  end

  def test_find_all_by_name_returns_empty_array_if_no_match
    expected = []
    actual = @merchant_repository.find_all_by_name("xyz")
    assert_equal expected, actual
  end

  def test_it_can_create_new_id
    expected = "12337412"
    actual = @merchant_repository.create_id
    assert_equal expected, actual
  end

  def test_it_create_new_merchant_with_attributes
    new_merchant_added = @merchant_repository.create({name: "Bill Nye"})
    expected = @merchant_repository.merchants[-1]
    actual = new_merchant_added.last
    assert_equal expected, actual
  end

  def test_it_can_update_name
    last_merchant = @merchant_repository.merchants[-1].name
    assert_equal "CJsDecor", last_merchant

    renamed_merchant = @merchant_repository.update(12337411, {name: "Eric LaSalle"})
    assert_equal "Eric LaSalle", renamed_merchant
  end

  def test_it_can_delete_merchant
    assert_equal @merchant_repository.merchants[0], @merchant_repository.find_by_name("Shopin1901")

    @merchant_repository.delete(12334105)
    assert_nil @merchant_repository.find_by_name("Shopin1901")
  end
end
