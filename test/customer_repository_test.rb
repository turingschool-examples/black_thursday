require './test/test_helper'
require './lib/customer_repository'

class CustomerRepositoryTest < Minitest::Test
  def setup
    file_path  = './data/sample_data/customers.csv'
    @cust_repo = CustomerRepository.new(file_path)
  end

  def test_all
# all - returns an array of all known Customers instances
  end

  def test_find_by_id
# find_by_id - returns either nil or an instance of Customer
#  with a matching ID
  end

  def test_find_by_first_name
# find_all_by_first_name - returns either []
# or one or more matches which have a first name matching
#  the substring fragment supplied
  end

  def test_find_by_last_name
# find_all_by_last_name - returns either []
# or one or more matches which have a last name matching
#  the substring fragment supplied
  end
end
