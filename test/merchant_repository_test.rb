require './test_helper'
require './lib/merchant'
require './lib/merchant_repository'
require 'pry'

class MerchantRepositoryTest < MiniTest::Test
  def test_it_exists
    mr = MerchantRepository.new

    assert_instance_of MerchantRepository, mr
  end

  def test_merchants_starts_as_an_empty_array
    mr = MerchantRepository.new

    assert_equal [], mr.all
  end

  def test_it_can_create_merchants
    mr = MerchantRepository.new
    attributes = {:id => 5, :name => 'Turing School'}
    mr.create(attributes)

    assert_equal 5, mr.all.first.id
    assert_equal 'Turing School', mr.all.first.name
  end

  def test_it_can_return_merchant_by_its_id
    mr = MerchantRepository.new
    attributes_1 = {:id => 5, :name => 'Turing School'}
    merchant_1 = mr.create(attributes_1)
    attributes_2 = {:id => 8, :name => 'Apple'}
    merchant_2 = mr.create(attributes_2)
    attributes_3 = {:id => 4, :name => 'Microsoft'}
    merchant_3 = mr.create(attributes_3)

    assert_equal merchant_1, mr.find_by_id(5)
    assert_equal merchant_2, mr.find_by_id(8)
    assert_equal merchant_3, mr.find_by_id(4)
  end

  def test_it_returns_nil_if_merchant_id_is_not_present
    mr = MerchantRepository.new
    attributes_1 = {:id => 5, :name => 'Turing School'}
    merchant_1 = mr.create(attributes_1)
    attributes_2 = {:id => 8, :name => 'Apple'}
    merchant_2 = mr.create(attributes_2)
    attributes_3 = {:id => 4, :name => 'Microsoft'}
    merchant_3 = mr.create(attributes_3)

    assert_nil mr.find_by_id(7)
  end

  def test_it_can_return_merchant_by_its_name
    mr = MerchantRepository.new
    attributes_1 = {:id => 5, :name => 'Turing School'}
    merchant_1 = mr.create(attributes_1)
    attributes_2 = {:id => 8, :name => 'Apple'}
    merchant_2 = mr.create(attributes_2)
    attributes_3 = {:id => 4, :name => 'Microsoft'}
    merchant_3 = mr.create(attributes_3)

    assert_equal merchant_1, mr.find_by_name('Turing School')
    assert_equal merchant_2, mr.find_by_name('Apple')
    assert_equal merchant_3, mr.find_by_name('Microsoft')
  end

  def test_it_returns_nil_if_merchant_name_is_not_present
    mr = MerchantRepository.new
    attributes_1 = {:id => 5, :name => 'Turing School'}
    merchant_1 = mr.create(attributes_1)
    attributes_2 = {:id => 8, :name => 'Apple'}
    merchant_2 = mr.create(attributes_2)
    attributes_3 = {:id => 4, :name => 'Microsoft'}
    merchant_3 = mr.create(attributes_3)

    assert_nil mr.find_by_name('Google')
  end

  def test_it_returns_array_of_merchants_by_their_name
    mr = MerchantRepository.new
    attributes_1 = {:id => 5, :name => 'Turing School'}
    merchant_1 = mr.create(attributes_1)
    attributes_2 = {:id => 8, :name => 'Apple School'}
    merchant_2 = mr.create(attributes_2)
    attributes_3 = {:id => 4, :name => 'Microsoft'}
    merchant_3 = mr.create(attributes_3)

    assert_equal [merchant_1, merchant_2], mr.find_all_by_name('Sch')
    assert_equal [merchant_3], mr.find_all_by_name('ros')
    assert_equal [], mr.find_all_by_name('Galvanize')
  end
end
