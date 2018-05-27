require './test_helper'
require './lib/merchant'
require './lib/merchant_repository'
require './lib/file_loader'
require 'pry'

class MerchantRepositoryTest < MiniTest::Test
  include FileLoader
  def test_it_exists
    data_from_file = load('./data/merchant_sample.csv')
    mr = MerchantRepository.new(data_from_file)

    assert_instance_of MerchantRepository, mr
  end

  def test_merchants_starts_as_an_empty_array
    data_from_file = load('./data/merchant_sample.csv')
    mr = MerchantRepository.new(data_from_file)

    assert_instance_of Array, mr.all
  end

  def test_it_can_create_merchants
    data_from_file = load('./data/merchant_sample.csv')
    mr = MerchantRepository.new(data_from_file)
    attributes = {:name => 'Turing School', :created_at => "2018-04-25", :updated_at => "2018-05-25"}
    mr.create(attributes)
    
    assert_equal 12334123, mr.all[-2].id
    assert_equal 12334124, mr.all[-1].id
    assert_equal 'Turing School', mr.all.last.name
  end

  def test_it_can_return_merchant_by_its_id
    skip
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
    skip
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
    skip
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
    skip
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
    skip
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

  def test_merchant_name_can_be_updated
    skip
    mr = MerchantRepository.new
    attributes_1 = {:id => 5, :name => 'Turing School'}
    merchant_1 = mr.create(attributes_1)
    attributes_2 = {:id => 8, :name => 'Apple'}
    merchant_2 = mr.create(attributes_2)
    attributes_3 = {:id => 4, :name => 'Microsoft'}
    merchant_3 = mr.create(attributes_3)
    new_attributes_1 = {:name => 'The Basement'}
    new_attributes_2 = {:name => 'Samsung'}
    new_attributes_3 = {:name => 'Xbox'}
    mr.update(5, new_attributes_1)
    mr.update(8, new_attributes_2)
    mr.update(4, new_attributes_3)

    assert_equal 'The Basement', merchant_1.name
    assert_equal 'Samsung', merchant_2.name
    assert_equal 'Xbox', merchant_3.name
    assert_equal 5, merchant_1.id
    assert_equal 8, merchant_2.id
    assert_equal 4, merchant_3.id
  end

  def test_merchant_can_be_deleted_by_id
    skip
    mr = MerchantRepository.new
    attributes_1 = {:id => 5, :name => 'Turing School'}
    merchant_1 = mr.create(attributes_1)
    attributes_2 = {:id => 8, :name => 'Apple'}
    merchant_2 = mr.create(attributes_2)
    attributes_3 = {:id => 4, :name => 'Microsoft'}
    merchant_3 = mr.create(attributes_3)

    assert_equal [merchant_1, merchant_2, merchant_3], mr.all

    mr.delete(8)

    assert_equal [merchant_1, merchant_3], mr.all
  end
end
