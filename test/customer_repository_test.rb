require 'csv'
require_relative 'test_helper'
require_relative '../lib/customer_repository'

class CustomerRepositoryTest < MiniTest::Test

  def setup
    @file_path = './test/data/customers_test.csv'
  end

  def test_if_class_creates
    cr = CustomerRepository.new(@file_path)

    assert_instance_of CustomerRepository, cr
  end

  def test_if_populates_repo_with_all
    cr = CustomerRepository.new(@file_path)

    assert_equal 10, cr.all.length
  end


end
