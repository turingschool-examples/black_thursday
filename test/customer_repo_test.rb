require "./test/test_helper"
require "./lib/customer_repo"

class CustomerRepoTest < Minitest::Test

  def test_what_happens
    filepath = "./data/support/customer_support.csv"
    customer_repo = CustomerRepo.new
    assert_equal Array, customer_repo.from_csv(filepath).class
  end

  def test_it_can_find_all_the_of_customers
    filepath = "./data/support/customer_support.csv"
    customer_repo = CustomerRepo.new
    customer_repo.from_csv(filepath)
    assert_equal 100, customer_repo.all.count
  end

  def test_it_can_find_a_customer_by_an_id
    filepath = "./data/support/customer_support.csv"
    customer_repo = CustomerRepo.new
    customer_repo.from_csv(filepath)
    assert_equal "Katrina", customer_repo.find_by_id(13).first_name
  end

  def test_it_cant_find_a_customer_by_an_invalid_id
    filepath = "./data/support/customer_support.csv"
    customer_repo = CustomerRepo.new
    customer_repo.from_csv(filepath)
    assert_equal nil, customer_repo.find_by_id(1415763241)
  end

  def test_it_can_find_a_customer_by_first_name
    filepath = "./data/support/customer_support.csv"
    customer_repo = CustomerRepo.new
    customer_repo.from_csv(filepath)
    assert_equal 1, customer_repo.find_all_by_first_name("Logan").count
  end

  def test_it_can_find_a_customer_by_partial_first_name
    filepath = "./data/support/customer_support.csv"
    customer_repo = CustomerRepo.new
    customer_repo.from_csv(filepath)
    assert_equal 56, customer_repo.find_all_by_first_name("a").count
  end

  def test_it_can_find_a_customer_by_last_name
    filepath = "./data/support/customer_support.csv"
    customer_repo = CustomerRepo.new
    customer_repo.from_csv(filepath)
    assert_equal 1, customer_repo.find_all_by_last_name("Hoppe").count
  end

  def test_it_can_find_a_customer_by_last_name_fragment
    filepath = "./data/support/customer_support.csv"
    customer_repo = CustomerRepo.new
    customer_repo.from_csv(filepath)
    assert_equal 30, customer_repo.find_all_by_last_name("o").count
  end

end
