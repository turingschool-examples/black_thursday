require_relative 'test_helper'
require_relative '../lib/customer_repository'

class CustomerRepositoryTest < Minitest::Test
  def setup
    @cr = CustomerRepository.new
    @cr.from_csv('./test/fixtures/customers_truncated.csv')
  end

  def test_all_returns_all_known_customers
    customers = @cr.all

    assert_equal , customers.length
    assert customers.all? do |customer|
      customer.class == Customer
    end
  end
end
#
# all - returns an array of all known Customers instances
# find_by_id - returns either nil or an instance of Customer with a matching ID
# find_all_by_first_name - returns either [] or one or more matches which have a first name matching the substring fragment supplied
# find_all_by_last_name - returns either [] or one or more matches which have a last name matching the substring fragment supplied
