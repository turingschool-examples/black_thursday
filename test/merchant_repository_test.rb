require './test/test_helper'

class MerchantRepositoryTest < Minitest::Test

  def test_it_exists
    mr = MerchantRepository.new('./test/data/merchant_sample.csv')
    assert_instance_of MerchantRepository, mr
  end

  def test_it_can_create_merchants
    mr = MerchantRepository.new("./test/data/merchant_sample.csv")
    assert_instance_of Array, mr.create_repo_array("./test/data/merchant_sample.csv")
  end

  def test_merchant_repo_has_merchants
    mr = MerchantRepository.new("./test/data/merchant_sample.csv")
    assert_equal 10, mr.all.count
  end

  def test_merchant_repo_can_find_them_by_id
    mr = MerchantRepository.new("./test/data/merchant_sample.csv")
    assert_instance_of Merchant, mr.find_by_id(12334105)
  end

  def test_merchant_repo_can_find_them_by_name
    mr = MerchantRepository.new("./test/data/merchant_sample.csv")
    assert_instance_of Merchant, mr.find_by_name('Shopin1901')
  end

  def test_merchant_repo_can_find_them_all_by_name
    mr = MerchantRepository.new("./test/data/merchant_sample.csv")
    assert_instance_of Merchant, mr.find_all_by_name('1901').first
  end

  def test_it_can_find_max_id_and_increase_it_by_one
    mr = MerchantRepository.new("./test/data/merchant_sample.csv")
    assert_equal 12334146, mr.new_highest_id
  end

  def test_merchant_repo_can_create_a_merchant
    mr = MerchantRepository.new("./test/data/merchant_sample.csv")
    new_merchant = mr.create({:name => 'Duck'})
    assert_equal 'Duck', new_merchant.name
    assert_equal 12334146, new_merchant.id
  end

  def test_we_can_update_attributes_for_merchant
    mr = MerchantRepository.new("./test/data/merchant_sample.csv")
    mr.create({:name => 'Larry'})
    updated_merchant = mr.update(12334145, {:name => 'Shiny Larry'})
    assert_equal 'Shiny Larry', updated_merchant.name
  end

  def test_it_can_delete_by_id
    mr = MerchantRepository.new('./test/data/merchant_sample.csv')
    mr.delete(12334123)
    assert_equal nil, mr.find_by_id(12334123)
  end

end
