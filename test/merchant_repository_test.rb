require_relative 'test_helper'
require './lib/merchant_repository'
require 'pry'

class MerchantRepositoryTest < MiniTest::Test

  def setup
    @merchant_repository = MerchantRepository.new(nil)
  end

  def test_that_merchants_are_created
    assert_equal 0, @merchant_repository.count
    @merchant_repository.create_merchant(:name => "Ali's Alliterations")

    assert_equal 1, @merchant_repository.count
  end

  def test_that_merchant_can_be_found_by_id
    @merchant_repository.create_merchant({:name => "Ali's Alliterations", :id => 5})
    merchant1 = @merchant_repository.merchants[0]
    assert_equal merchant1, @merchant_repository.find_by_id(5)
  end

  def test_that_merchant_can_be_found_by_name
    @merchant_repository.create_merchant({:name => "Ali's Alliterations", :id => 5})
    merchant1 = @merchant_repository.merchants[0]

    assert_nil @merchant_repository.find_by_name("Jimmy Joe Bob")
    assert_equal merchant1, @merchant_repository.find_by_name("aLi's AllIteraTions")
  end

  def test_that_it_can_find_all_by_name
    @merchant_repository.create_merchant({:name => "Ali's Alliterations", :id => 5})
    @merchant_repository.create_merchant({:name => "Alligator Jerky", :id => 10})
    merchant1 = @merchant_repository.merchants[0]
    merchant2 = @merchant_repository.merchants[1]

    assert_empty @merchant_repository.find_all_by_name("Jimmy Joe Bob")
    assert_equal [merchant1, merchant2], @merchant_repository.find_all_by_name("aLli")
  end

end
