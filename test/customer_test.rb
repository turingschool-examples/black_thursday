require_relative '../lib/customer'
require_relative 'spec_helper'
require          'pry'
require          'minitest/autorun'
require          'minitest/pride'


class CustomerTest < Minitest::Test
  attr_reader :repo
  def test_class_exist
    assert Customer
  end

  def setup
    @repo = Customer.new({
          :id => 6,
          :first_name =>       "Joan",
          :last_name =>      "Clarke",
          :created_at => "2009-02-07",
          :updated_at => "2014-03-15",
        })
  end

  def test_that_all_customer_attributes_work
    assert_equal                        6, repo.id
    assert_equal                   "Joan", repo.first_name
    assert_equal                 "Clarke", repo.last_name
    assert_equal Time.parse("2009-02-07"), repo.created_at
    assert_equal Time.parse("2014-03-15"), repo.updated_at
  end



end
