require 'test_helper'
require './lib/merchant_repository'
require './lib/merchant'

class MerchantRepositoryTest < Minitest::Test
  def test_it_exists
    mr = MerchantRepository.new

    assert_instance_of MerchantRepository, mr
  end

  def test_all_returns_array_of_known_merchants
    mr = MerchantRepository.new

    assert_equal 1, mr.all.count
  end

  def test_find_by_id
    mr = MerchantRepository.new
    m = Merchant.new({:id => 5, :name => "Turing School"})

    assert_equal m, mr.find_by_id(5)
  end

  def test_find_by_name
    mr = MerchantRepository.new
    m = Merchant.new({:id => 5, :name => "Turing School"})

    assert_equal m, mr.find_by_name("Turing School")
  end

  def test_find_all_by_name
    mr = MerchantRepository.new
    m = Merchant.new({:id => 5, :name => "Turing School"})
    m2 = Merchant.new({:id => 6, :name => "Turing School"})

    assert_equal [m, m2], mr.find_all_by_name("Turing School")
  end

  def test_create
    mr = MerchantRepository.new
    mr.create({:id => 10, :name => "Asa"})

    assert mr.all.map(&:id).include?(10)
  end

  def test_update
    mr = MerchantRepository.new
    m = Merchant.new({:id => 5, :name => "Programming"})

    assert_equal m, mr.update(5, {:name => "Programming"})
  end

  def test_delete
    mr = MerchantRepository.new
     mr.delete(5)

    refute mr.all.map(&:id).include?(5)
  end
end
