require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/merchant_repository'
require_relative '../lib/merchant'
require 'pry'

class MerchantRepositoryTest < Minitest::Test

  def test_it_exists
    mr = MerchantRepository.new

    assert_instance_of MerchantRepository, mr
  end

  def test_it_has_no_merchants_by_default
    mr = MerchantRepository.new

    assert_equal [], mr.merchants
  end

  def test_we_can_add_merchants
    mr = MerchantRepository.new
    m = Merchant.new({:id => 5, :name => "Turing School"})
    m2 = Merchant.new({:id => 6, :name => "Basement"})

    mr.add_merchant(m)

    assert_equal [m], mr.merchants

    mr.add_merchant(m2)

    assert_equal [m,m2], mr.merchants

  end

  def test_we_return_all_the_merchants
    mr = MerchantRepository.new
    m = Merchant.new({:id => 5, :name => "Turing School"})
    m2 = Merchant.new({:id => 6, :name => "Basement"})

    mr.add_merchant(m)
    mr.add_merchant(m2)

    assert_equal [m,m2], mr.all

  end

  def test_we_can_find_merchant_by_id
    mr = MerchantRepository.new
    m = Merchant.new({:id => 5, :name => "Turing School"})
    m2 = Merchant.new({:id => 6, :name => "Basement"})

    mr.add_merchant(m)
    mr.add_merchant(m2)

    actual = mr.find_by_id(6).name

    assert_equal "Basement", actual

  end

  def test_we_can_find_merchant_by_name
    mr = MerchantRepository.new
    m = Merchant.new({:id => 5, :name => "Turing School"})
    m2 = Merchant.new({:id => 6, :name => "Basement"})

    mr.add_merchant(m)
    mr.add_merchant(m2)

    actual = mr.find_by_name("basement").name

    assert_equal "Basement", actual

  end

  def test_we_can_find_all_merchants_by_name
    mr = MerchantRepository.new
    m = Merchant.new({:id => 5, :name => "Turing School"})
    m2 = Merchant.new({:id => 6, :name => "Basement"})
    m3 = Merchant.new({:id => 7, :name => "BaseMent"})
    m4 = Merchant.new({:id => 8, :name => "bAsEmEnT"})

    mr.add_merchant(m)
    mr.add_merchant(m2)
    mr.add_merchant(m3)
    mr.add_merchant(m4)

    actual = mr.find_all_by_name("basement")

    assert_equal [m2,m3,m4], actual

  end


end
