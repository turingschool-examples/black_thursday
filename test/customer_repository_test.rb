require_relative 'test_helper'
require_relative '../lib/customer_repository'

class CustomerRepostioryTest < Minitest::Test

  attr_reader :repo, :parent

  def setup
    @parent = Minitest::Mock.new
    @repo = CustomerRepository.new('./test/assets/test_customers.csv', parent) 
  end

  def test_repo_all_holds_array_of_customers
    assert_equal 31, repo.all.count
  end

  def test_repo_holds_customer_instances_that_are_accessible
    assert_equal 1, repo.all[0].id
  end

  def test_repo_can_find_customer_given_id
    assert_equal 'Lucille', repo.find_by_id(12).first_name
  end

  def test_repo_returns_nil_given_nonexsistant_id
    assert_equal nil, repo.find_by_id(1001)
  end

  def test_it_returns_array_with_all_customers_with_first_name
    assert_equal 1, repo.find_all_by_first_name('Lucille').count
  end

  def test_it_returns_empty_array_when_first_name_not_found
    assert_equal [], repo.find_all_by_first_name("Dragon")
  end

  def test_it_returns_array_with_all_customers_with_last_name
    assert_equal 1, repo.find_all_by_last_name('Homenick').count
  end

  def test_it_returns_empty_array_when_last_name_not_found
    assert_equal [], repo.find_all_by_last_name("Dragon")
  end

  def test_it_calls_parent_when_looking_for_invoices
    parent.expect(:find_invoices_by_customer_id, nil, [6])
    repo.find_invoices_by_customer_id(6)
    parent.verify
  end

end