require_relative 'test_helper'
require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/customer_repository'

class CustomerRepositoryTest < MiniTest::Test
  attr_reader :cr

  def setup
    @cr = CustomerRepository.new([
      { :id => "1",
        :first_name => "Helen",
        :last_name => "Smith",
        :created_at => "2012-03-27 14:54:09 UTC",
        :updated_at => "2012-03-28 15:54:09 UTC"
      },
        { :id => "2",
          :first_name => "Harry",
          :last_name => "Wilson",
          :created_at => "2014-03-27 14:54:09 UTC",
          :updated_at => "2012-04-28 15:54:09 UTC"
        }
      ])
    end

  def test_it_returns_array_of_all_customers
    assert_equal Array, cr.all.class
  end

  def test_it_finds_invoice_item_by_id
    assert_equal "Harry", cr.find_by_id(2).first_name
  end







end
