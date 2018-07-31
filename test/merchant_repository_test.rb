require_relative 'test_helper'
require_relative '../lib/merchant_repository.rb'

class MerchantRepositoryTest < Minitest::Test
  def setup
    merchant_1 = Merchant.new({
      name: "Bills Tools",
      id: "123",
      created_at: "2010-12-10",
      updated_at: "2011-12-04"
      })
    merchant_2 = Merchant.new({
      name: "Billys Tools",
      id: "124",
      created_at: "2010-12-10",
      updated_at: "2011-12-04"
      })
    merchant_3 = Merchant.new({
      name: "Bilbos Tools",
      id: "125",
      created_at: "2010-12-10",
      updated_at: "2011-12-04"
      })

    merchants = [merchant_1, merchant_2, merchant_3]
    @merchant_repository = MerchantRepository.new(merchants)
  end

  def test_it_exists
    assert_instance_of MerchantRepository, @merchant_repository
  end

  def test_it_can_hold_merchants
    assert_instance_of Array, @merchant_repository.list
  end

  def test_its_holding_merchants
    assert_instance_of Merchant, @merchant_repository.list[0]
    assert_instance_of Merchant, @merchant_repository.list[2]
  end

  def test_it_can_return_merchants_using_all
    assert_instance_of Merchant, @merchant_repository.all[0]
    assert_instance_of Merchant, @merchant_repository.all[2]
  end

  def test_it_can_find_by_id
    expected = @merchant_repository.list[0]
    actual = @merchant_repository.find_by_id(123)
    assert_equal expected, actual
  end

  def test_it_can_find_by_name
    expected = @merchant_repository.list[0]
    actual = @merchant_repository.find_by_name("Bills Tools")
    assert_equal expected, actual
  end

  def test_it_can_find_all_by_name
    expected = 3
    actual = @merchant_repository.find_all_by_name("bil").count
    assert_equal expected, actual
    actual_2 = @merchant_repository.find_all_by_name("BIL").count
    assert_equal expected, actual_2
  end

  def test_find_all_by_name_returns_empty_array_if_no_match
    expected = []
    actual = @merchant_repository.find_all_by_name("xyz")
    assert_equal expected, actual
  end

  def test_it_can_create_new_id
    expected = "126"
    actual = @merchant_repository.create_id
    assert_equal expected, actual
  end

  def test_it_create_new_merchant_with_attributes
    new_merchant_added = @merchant_repository.create({name: "Bill Nye"})
    expected = @merchant_repository.list[-1]
    actual = new_merchant_added.last
    assert_equal expected, actual
  end

  def test_it_can_update_name
    last_merchant = @merchant_repository.list[-1].name
    assert_equal "Bilbos Tools", last_merchant

    renamed_merchant = @merchant_repository.update(125, {name: "Eric LaSalle"})
    assert_equal "Eric LaSalle", renamed_merchant
  end

  def test_it_can_delete_merchant
    assert_equal @merchant_repository.list[1], @merchant_repository.find_by_name("Billys Tools")

    @merchant_repository.delete(124)
    assert_nil @merchant_repository.find_by_name("Billys Tools")
  end
end
