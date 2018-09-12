require_relative './test_helper'
require_relative '../lib/merchant'
require_relative '../lib/merchant_repository'

class MerchantRepositoryTest < Minitest::Test

  def test_it_exists
    mr = MerchantRepository.new("./data/merchants.csv")

    assert_instance_of MerchantRepository, mr
  end

  def test_it_can_split_csv
    mr = MerchantRepository.new("./data/test_merchants.csv")

    assert_equal "Shopin1901", mr.find_by_id(12334105).name
  end

  def test_it_can_add_individual_merchant
    mr = MerchantRepository.new
    m1 = Merchant.new({:id => 5, :name => "Turing School"})
    mr.add_individual_item(m1)

    assert_equal [m1], mr.all
  end

  def test_it_can_return_merchants
    mr = MerchantRepository.new
    m1 = Merchant.new({:id => 5, :name => "Turing School"})
    m2 = Merchant.new({:id => 1, :name => "Galvanize Schools"})
    mr.add_individual_item(m1)
    mr.add_individual_item(m2)

    assert_equal [m1,m2], mr.all
  end

  def test_it_can_find_by_name
    mr = MerchantRepository.new
    m1 = Merchant.new({:id => 5, :name => "Turing School"})
    m2 = Merchant.new({:id => 1, :name => "Galvanize Schools"})
    mr.add_individual_item(m1)
    mr.add_individual_item(m2)

    assert_equal m2, mr.find_by_name("Galvanize")
    assert_equal m1, mr.find_by_name("school")
    refute_equal m2, mr.find_by_name("school")
  end

  def test_it_can_find_all_by_name
    mr = MerchantRepository.new
    m1 = Merchant.new({:id => 5, :name => "Turing School"})
    m2 = Merchant.new({:id => 1, :name => "Galvanize Schools"})
    m3 = Merchant.new({:id => 3, :name => "Alan Turing"})
    mr.add_individual_item(m1)
    mr.add_individual_item(m2)
    mr.add_individual_item(m3)

    assert_equal [m1,m2], mr.find_all_by_name("school")
    assert_equal [m1, m3], mr.find_all_by_name("turing")
  end

  def test_it_can_create_merchant_with_empty_array
    mr = MerchantRepository.new

    mr.create({:id => 490, :name => "Jim Flooring"})
    actual = mr.find_by_id(490).name
    assert_equal "Jim Flooring", actual
  end

  def test_it_can_create_merchant_without_passing_id
    mr = MerchantRepository.new
    m1 = Merchant.new({:id => 5, :name => "Turing School"})
    m2 = Merchant.new({:id => 1, :name => "Galvanize Schools"})

    mr.add_individual_item(m1)
    mr.add_individual_item(m2)

    mr.create({:name => "Jim Flooring"})
    actual = mr.find_by_id(6).name
    assert_equal "Jim Flooring", actual
  end

  def test_it_can_create_merchant_with_existing_id
    mr = MerchantRepository.new
    m1 = Merchant.new({:id => 5, :name => "Turing School"})
    m2 = Merchant.new({:id => 1, :name => "Galvanize Schools"})

    mr.add_individual_item(m1)
    mr.add_individual_item(m2)

    mr.create({:id => 5, :name => "Jim Flooring"})
    actual = mr.find_by_id(6).name
    assert_equal "Jim Flooring", actual
  end

  def test_it_can_update_merchant
    mr = MerchantRepository.new
    m1 = Merchant.new({:id => 5, :name => "Turing School"})
    m2 = Merchant.new({:id => 1, :name => "Galvanize Schools"})
    mr.add_individual_item(m1)
    mr.add_individual_item(m2)
    mr.update(5, {:id => 9, :name => "The Best School"})

    actual = mr.find_by_id(5).name
    assert_equal "The Best School", actual
  end

  def test_it_can_delete_merchants
    mr = MerchantRepository.new
    m1 = Merchant.new({:id => 5, :name => "Turing School"})
    m2 = Merchant.new({:id => 1, :name => "Galvanize Schools"})
    mr.add_individual_item(m1)
    mr.add_individual_item(m2)
    mr.delete(5)

    assert_equal [m2], mr.all
  end

end
