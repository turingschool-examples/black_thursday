require_relative 'test_helper'
require_relative '../lib/merchant_repository'

### write a test for parse_merchants

class MerchantRepositoryTest < Minitest::Test 

  attr_reader :repo, :parent

  def setup
    @parent = Minitest::Mock.new
    @repo = MerchantRepository.new('./test/assets/merchant_repository_data.csv', parent)
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

  def test_it_can_access_parent_when_looking_for_merchant_items
    parent.expect(:find_items_by_merchant_id, nil, [1])
    repo.find_items_by_merchant_id(1)
    parent.verify
  end

  def test_it_can_access_parent_when_looking_for_invoices
    parent.expect(:find_invoices_by_merchant_id, nil, [1])
    repo.find_invoices_by_merchant_id(1)
    parent.verify
  end

  def test_it_can_access_parent_when_looking_for_customers
    parent.expect(:find_customer_by_id, nil, [1])
    repo.find_customer_by_customer_id(1)
    parent.verify
  end

end