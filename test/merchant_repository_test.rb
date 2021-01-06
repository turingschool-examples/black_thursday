require 'minitest/autorun'
require 'minitest/pride'
require './lib/merchant_repository'
require './lib/merchant'
require './lib/sales_engine'
require 'csv'

class MerchantRepositoryTest < Minitest::Test

  def setup
    mr = MerchantRepository.new("./data/merchants.csv")
    @merchants = []

  end
  def test_it_exists_and_has_attributes
    mr = MerchantRepository.new("./data/merchants.csv")

  assert_instance_of MerchantRepository, mr
  assert_equal "./data/merchants.csv", mr.path
  end

  def test_it_can_read_merchants
    mr = MerchantRepository.new("./data/merchants.csv")

    assert_equal 475, mr.merchants.count
  end

  def test_it_can_return_all
    mr = MerchantRepository.new("./data/merchants.csv")

    assert_instance_of Merchant, mr.all[0]
  end

  def test_find_by_id
    mr = MerchantRepository.new("./data/merchants.csv")

    assert_equal "Candisart", mr.find_by_id(12334112).name
    assert_equal "CJsDecor", mr.find_by_id(12337411).name
    assert_nil mr.find_by_id(1233741)
  end

  def test_find_by_name
    mr = MerchantRepository.new("./data/merchants.csv")

    assert_equal 12334112, mr.find_by_name("Candisart").id
    assert_nil mr.find_by_name("abc")
  end

  def test_find_all_by_name
    mr = MerchantRepository.new("./data/merchants.csv")
    m = Merchant.new({:id => 12334112, :name => "Candisart"})

    assert_equal [m].count, mr.find_all_by_name("andisar").count
    assert_equal [], mr.find_all_by_name("abc")
  end

  def test_create_attributes_adds_merchant_objects
    mr = MerchantRepository.new("./data/merchants.csv")
    mr.create({:name => "Ruby"})
    assert_equal 12337412, mr.merchants.last.id
  end

  def test_update_changes_merchant_object_names
    mr = MerchantRepository.new("./data/merchants.csv")
    mr.update(12334112, "Harry's Appliances")
    assert_equal "Harry's Appliances", mr.find_by_id(12334112).name

  end

  def test_delete_removes_merchant_object
    mr = MerchantRepository.new("./data/merchants.csv")
    mr.delete(12334112)
    assert_nil mr.find_by_id(12334112)
  end
end
