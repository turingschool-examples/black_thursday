require './test/test_helper'
require './lib/customer_repo'

class CustomerRepositoryTest < Minitest::Test

  def setup
    csvfile = CSV.open "./data/customers.csv", headers: true, header_converters: :symbol
    @customer_repo = CustomerRepository.new(csvfile, "engine")
  end


  def test_it_exist
    assert_instance_of CustomerRepository, @customer_repo
  end

  def test_can_find_by_id
    customer_id = 1
    invalid_id = 0

    assert_instance_of Customer, @customer_repo.find_by_id(customer_id)
    assert_nil @customer_repo.find_by_id(invalid_id)
  end

  def test_can_find_all_by_first_name
    first_name = "Joey"

    assert_instance_of Array, @customer_repo.find_all_by_first_name(first_name)
  end

  def test_can_find_all_by_last_name
    last_name = "Ondricka"

    assert_instance_of Array, @customer_repo.find_all_by_last_name(last_name)
  end

end
