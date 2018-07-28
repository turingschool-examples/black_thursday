#frozen_string_literal: true

require 'simplecov'
SimpleCov.start

require 'minitest/autorun'
require 'minitest/pride'

require './lib/customer_repository'

# Customer repository test class
class CustomerRepositoryTest < Minitest::Test
  def setup
    @cr = CustomerRepository.new
  end

  def test_it_exists
    assert_instance_of CustomerRepository, @cr
  end

  def test_it_can_create_a_customer_instance
    actual = @cr.create(id: 7, first_name: "Wes", last_name: "Anderson")

    assert_instance_of Customer, actual
  end
end
