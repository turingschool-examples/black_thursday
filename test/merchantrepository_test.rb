require './lib/salesengine'
require './lib/merchantrepository'
require 'minitest/autorun'
require 'minitest/pride'
require 'csv'
class MerchantRepositoryTest < Minitest::Test
  def test_it_exists
    mr = MerchantRepository.new
    assert_instance_of MerchantRepository, mr
  end

  def test_merchant_has_attributes
    mr = MerchantRepository.new
    merchant = mr.create({:id => 5, :name => "Turing School"})
    assert_equal 5, merchant.id
    assert_equal "Turing School", merchant.name
  end

  def test_all
    mr = MerchantRepository.new
    assert_equal [], mr.all
  end

  def test_find_by_id
    mr = MerchantRepository.new
    assert_equal nil, mr.find_by_id("12334105")
  end

  def test_find_by_name
    mr = MerchantRepository.new
    assert_equal nil, mr.find_by_id("Shopin1901")
  end

  def test_find_all_by_name
    mr = MerchantRepository.new
    assert_equal [], mr.find_all_by_name("Shop")
  end

  def test_update_merchant
    se = SalesEngine.new
    mr = se.merchants
    assert_equal "Shopin1901", merchant.name
    mr.update("12334105", "Shopin2018")
    assert_equal "Shopin2018", merchant.name
  end

  def test_delete_merchant
    se = SalesEngine.new
    mr = se.merchants
    assert mr.find_by_id("12334105")
    mr.delete("12334105")
    refute mr.find_by_id("12334105")
  end



end
