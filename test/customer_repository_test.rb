require_relative './test_helper'


class CustomerRepositoryTest < Minitest::Test

  def test_it_exists
    cr = CustomerRepository.new('./test/data/invoice_test_data.csv')
    assert_instance_of CustomerRepository, cr
  end

end
