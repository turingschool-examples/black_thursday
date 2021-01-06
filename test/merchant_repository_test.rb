require './test/test_helper'

class MerchantRepositoryTest < Minitest::Test
  def setup
    args_1 = {id: 12334105, name: "Shopin1901"}
    args_2 = {id: 12334112, name: "Candisart"}
    args_3 = {id: 12334113, name: "MiniatureBikez"}
    args_4 = {id: 12334115, name: "LolaMarleys"}
    @merchant_1 = Merchant.new(args_1[:id], args_1[:name])
    @merchant_2 = Merchant.new(args_2[:id], args_2[:name])
    @merchant_3 = Merchant.new(args_3[:id], args_3[:name])
    @merchant_4 = Merchant.new(args_4[:id], args_4[:name])
    merchant_path = "./data/merchant_repo_test.csv"
    arguments = merchant_path
    @mr = MerchantRepository.new(arguments)
  end

  def test_it_exists_and_has_attributes
    assert_instance_of MerchantRepository, @mr
    assert_equal 4, @mr.merchants.length
  end

  def test_it_has_attributes
    assert_equal 12334105, @mr.merchants.first.id
    assert_equal 'Shopin1901', @mr.merchants.first.name
    assert_equal 12334115, @mr.merchants.last.id
    assert_equal 'LolaMarleys', @mr.merchants.last.name
  end

  def test_it_can_return_all_merchants
    assert_equal 4, @mr.all.length
  end

  def test_it_can_find_merchants_by_id
    # assert_equal [@merchant_1], @mr.find_by_id(12334105)
    assert_nil @mr.find_by_id(123341059)
  end

  def test_it_can_find_merchants_by_name
    # assert_equal @merchant_1, @mr.find_by_name("Shopin1901")
    assert_nil @mr.find_by_name("Shopin1901fg")
  end

  def test_it_can_find__all_merchants_by_name
    # assert_equal [@merchant_2], @mr.find_all_by_name("Candisart")
    assert_equal [], @mr.find_all_by_name("Candisart_2")
  end

  def test_highest_merchant_id_plus_one
    assert_equal 12334116, @mr.highest_merchant_id_plus_one
  end

  def test_it_can_create_new_merchants
    merchant_5 = @mr.create("jolly's candies")
    assert_instance_of Merchant, merchant_5
    assert_equal "jolly's candies", merchant_5.name
    assert_equal 12334116, merchant_5.id
    assert_equal 5, @mr.all.length
  end

  def test_it_can_update_name_of_merchant
    merchant_6 = @mr.create("jesus's burgers")

    assert_equal "jesus's burgers", merchant_6.name

    @mr.update(12334116, "jesus's tacos")

    assert_equal "jesus's tacos", merchant_6.name
  end

  def test_it_can_delete_merchants
    assert_equal 4, @mr.all.length
    @mr.delete(12334115)
    assert_equal 3, @mr.all.length
    assert_nil @mr.find_by_id(12334115)
  end
end
