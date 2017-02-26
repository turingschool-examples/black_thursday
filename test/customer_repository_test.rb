require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/customer_repository'


class CustomerRepositoryTest < Minitest::Test
  attr_reader :cr

  def setup
    @cr = CustomerRepository.new('test/fixtures/customer_fixture.csv')
  end

  def test_pull_csv
    assert_instance_of CSV, cr.pull_csv
  end
end
