require_relative 'test_helper'
require_relative '../lib/merchant_repository'
require 'pry'

class MerchantRepositoryTest < Minitest::Test

  def setup
    merchant1 = Merchant.new({:id => 12334105, :name => "Shopin1901"})
    merchant2 = Merchant.new({:id => 12334112, :name => "Candisart"})
    @merchant_repo = MerchantRepository.new
    @merchant_repo.merchant_array = ([merchant1, merchant2])
  end

  def test_it_created_instance_of_merchant_repo_class
    assert_equal MerchantRepository, @merchant_repo.class
  end

  def test_it_returns_merchant_by_finding_id
    assert_equal "Shopin1901", @merchant_repo.find_by_id(12334105).name
    assert_equal "Candisart", @merchant_repo.find_by_id(12334112).name
  end

  def test_it_returns_merchant_by_finding_name
    assert_equal 12334105, @merchant_repo.find_by_name("Shopin1901").id
    assert_equal 12334112, @merchant_repo.find_by_name("Candisart").id
  end

  def test_it_finds_all_instances_with_given_name_fragment
    merchant1 = Merchant.new({:id => 12334105, :name => "Shopin1901"})
    merchant2 = Merchant.new({:id => 12334112, :name => "Candisart"})
    merchant3 = Merchant.new({:id => 12345678, :name => "ShopsRUs"})
    merchant_repo = MerchantRepository.new
    merchant_repo.merchant_array = ([merchant1, merchant2, merchant3])
    output = merchant_repo.find_all_by_name("shop")

    assert_equal 2, output.length
  end
end
