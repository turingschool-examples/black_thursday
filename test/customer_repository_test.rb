require_relative '../lib/customer_repository'
require_relative 'spec_helper'
require          'pry'
require          'minitest/autorun'
require          'minitest/pride'


class CustomerRepositoryTest < Minitest::Test

  def test_class_exist
    assert CustomerRepository
  end

end
