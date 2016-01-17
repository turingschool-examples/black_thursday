require_relative '../lib/invoice_repository'
require_relative 'spec_helper'
require          'pry'
require          'minitest/autorun'
require          'minitest/pride'


class InvoiceRepositoryTest < Minitest::Test
  attr_reader :repo

  def test_class_exist
    assert InvoiceRepository
  end

  def setup
    @repo = InvoiceRepository.new([
        {id: 1, customer_id: 11, merchant_id: 1111, status: "pending", :created_at=>"2016-01-11 10:37:09 UTC", :updated_at=>"2016-01-11 10:37:09 UTC"},
        {id: 2, customer_id: 22, merchant_id: 2222, status: "shipped", :created_at=>"2016-01-11 10:37:09 UTC", :updated_at=>"2016-01-11 10:37:09 UTC"},
        {id: 3, customer_id: 33, merchant_id: 3333, status: "pending", :created_at=>"2016-01-11 10:37:09 UTC", :updated_at=>"2016-01-11 10:37:09 UTC"},
        {id: 4, customer_id: 44, merchant_id: 4444, status: "shipped", :created_at=>"2016-01-11 10:37:09 UTC", :updated_at=>"2016-01-11 10:37:09 UTC"},
        {id: 5, customer_id: 55, merchant_id: 5555, status: "pending", :created_at=>"2016-01-11 10:37:09 UTC", :updated_at=>"2016-01-11 10:37:09 UTC"},
        ])
  end

  def test_that_all_method_exist
    assert InvoiceRepository.method_defined? :all
  end

  def test_that_find_by_id_method_exist
    assert InvoiceRepository.method_defined? :find_by_id
  end

  def test_that_find_all_by_customer_id_method_exist
    assert InvoiceRepository.method_defined? :find_all_by_customer_id
  end

  def test_that_find_all_by_merchant_id_method_exist
    assert InvoiceRepository.method_defined? :find_all_by_merchant_id
  end

  def test_that_find_all_by_status_method_exist
    assert InvoiceRepository.method_defined? :find_all_by_status
  end

  def test_that_the_all_method_returns_an_array
    assert_kind_of(Array, repo.all)
  end

  def test_that_find_by_id_works
    assert_equal      5555, repo.find_by_id(5).merchant_id
    assert_equal "pending", repo.find_by_id(5).status
    assert_equal        55, repo.find_by_id(5).customer_id
  end

end
