require 'simplecov'
SimpleCov.start

require 'minitest/pride'
require 'minitest/autorun'
require_relative '../lib/merchant'
require_relative '../lib/merchant_repository'
require_relative '../lib/sales_engine'


class MerchantRespositoryTest < Minitest::Test

  def setup
    @merchant_repository = MerchantRepository.new
    @merchant_repository.create_with_id({id: 1,
                                         name: "Dylan",
                                         created_at: "2010-12-10",
                                         updated_at: "2011-09-15"})
    @merchant_repository.create_with_id({id: 2,
                                         name: "Allison",
                                         created_at: "2015-04-12",
                                         updated_at: "2018-01-07"})
    @merchant_repository.create_with_id({id: 3,
                                         name: "Carl",
                                         created_at: "2012-08-11",
                                         updated_at: "2018-02-03"})
    @merchant_repository.create_with_id({id: 4,
                                         name: "Carl's Jr's",
                                         created_at: "2012-08-11",
                                         updated_at: "2018-02-03"})
  end

  def test_it_exists
    assert_instance_of MerchantRepository, @merchant_repository
  end

  def test_it_starts_with_no_merchants
    merchant_repository = MerchantRepository.new
    assert_equal [], merchant_repository.all
  end

  def test_it_stores_all_merchants
    expected = 4
    result = @merchant_repository.all.count

    assert_equal expected, result
  end

  def test_we_can_find_a_merchant_by_id
    id = 1
    result = @merchant_repository.find_by_id(id).id
    assert_equal id, result
  end

  def test_we_can_find_merchant_by_name
    name = "Dylan"
    result = @merchant_repository.find_by_name(name).name
    assert_equal name, result
  end

  def test_we_can_find_all_merchants_by_name
    merchant_1 = @merchant_repository.find_by_id(3)
    merchant_2 = @merchant_repository.find_by_id(4)
    expected = [merchant_1, merchant_2]
    result = @merchant_repository.find_all_by_name("Carl")
    assert_equal expected, result
  end

  def test_we_can_create_a_merchant_instance
    @merchant_repository.create({name: "James"})
    found = @merchant_repository.find_by_name("James")
    assert_instance_of Merchant, found
  end

  def test_we_can_update_a_merchants_name_by_id
    expected = "Ben"
    @merchant_repository.update(1, {name: "Ben"})
    result = @merchant_repository.find_by_id(1).name
    assert_equal expected, result
  end

  def test_we_can_delete_a_merchant_instance
    expected = nil
    @merchant_repository.delete(12336143)
    result = @merchant_repository.find_by_id(12336143)
    assert_equal expected, result
  end

end
