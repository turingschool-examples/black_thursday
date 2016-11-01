require './test/test_helper'
require './lib/merchant_repository'


class MerchantRepositoryTest < Minitest::Test 

  attr_reader :repo

  def setup
    @repo = MerchantRepository.new([ Merchant.new({:id => 5, :name => "Bob"}), 
                                     Merchant.new({:id => 1, :name => "Walmart"}), 
                                     Merchant.new({:id => 2, :name => "TarboB"})])
  end

  def test_it_returns_array_of_all_merchants
    assert_equal "Bob", repo.all[0].name
    assert_equal 3, repo.all.count
  end

  def test_it_returns_nil_if_no_merchants_match_id 
    assert_equal nil, repo.find_by_id(7)
  end

  def test_it_returns_merchant_instance_if_id_is_present
    assert_equal "Bob", repo.find_by_id(5).name
  end

  def test_it_returns_nil_if_no_merchants_match_name
    assert_equal nil, repo.find_by_name("Rufio")
  end

  def test_it_returns_merchant_instance_if_name_is_present
    assert_equal 5, repo.find_by_name("Bob").id
  end

  def test_it_can_find_merchant_instance_with_case_insensitive
    assert_equal 5, repo.find_by_name("bob").id
  end

  def test_empty_array_is_returned_if_name_fragment_doesnt_match_merchant_name
    assert_equal [], repo.find_all_by_name("Stew")
  end

  def test_it_can_find_all_merchant_instances_with_case_insenstive_name
    assert_equal 2, repo.find_all_by_name("Bob").count
  end

end