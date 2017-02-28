require './test/test_helper'

class CustomerTest < Minitest::Test

attr_reader :customer_1, :customer_2, :customer_3, :customer_list, :customer_repo

  def setup
    @customer_1 = Customer.new({ id:"1", first_name: "Joey", last_name: "Ondricka", created_at: "2012-03-27 14:54:09 UTC", updated_at: "2012-03-27 14:54:09 UTC"})
    @customer_2 = Customer.new({ id:"2", first_name: "Mark", last_name: "Ondricka", created_at: "2012-03-27 14:54:09 UTC", updated_at: "2012-03-27 14:54:09 UTC"})
    @customer_3 = Customer.new({ id:"3", first_name: "Joey", last_name: "Stover", created_at: "2012-03-27 14:54:09 UTC", updated_at: "2012-03-27 14:54:09 UTC"})
    @customer_list = [customer_1, customer_2, customer_3]
    @customer_repo = CustomerRepository.new(customer_list)
  end

  def test_it_exists
    assert_instance_of CustomerRepository, customer_repo
  end

  def test_all
    assert_equal customer_list, customer_repo.all
  end

  def test_find_by_id
    assert_equal customer_1, customer_repo.find_by_id(1)
  end

  def test_find_all_by_first_name
    assert_equal [customer_2], customer_repo.find_by_first_name("Mark")
  end

  def test_find_all_by_last_name
    assert_equal [customer_3], customer_repo.find_by_last_name("Stover")
  end
end
