# frozen_string_literal: true

require_relative 'test_helper'
require_relative '../lib/invoice_repo'

class InvoiceRepoTest < Minitest::Test
  attr_reader :invoice_repo,
              :parent,
              :attrs

  def setup
    @attrs = { id: 5,
               customer_id: 1,
               merchant_id: 12_335_938,
               status: 'pending',
               created_at: '2018-04-10',
               updated_at: '2018-04-10' }
    data = LoadFile.load('./test/fixture_data/invoice_1.csv')
    @parent = Minitest::Mock.new
    @invoice_repo = InvoiceRepo.new(data, parent)
  end

  def test_it_exists
    assert_instance_of InvoiceRepo, invoice_repo
  end

  def test_it_returns_am_array_of_all_invoices
    assert_equal 201, invoice_repo.all.count
    assert_instance_of Array, invoice_repo.all
    assert_instance_of Invoice, invoice_repo.all.sample
  end

  def test_it_returns_nil_if_there_is_no_id
    assert_nil invoice_repo.find_by_id(21341242135123)
  end

  def test_it_can_find_all_customers
    assert_equal 8, invoice_repo.find_all_by_customer_id(1).count
  end

  def test_it_returns_array_if_no_valid_cust_id
    assert_equal [], invoice_repo.find_all_by_customer_id(0o000000)
  end

  def test_it_can_find_all_by_merchant_id
    assert_equal 10, invoice_repo.find_all_by_merchant_id(12335938).count
  end

  def test_it_returns_empty_array_if_no_valid_merchant_id
    assert_equal [], invoice_repo.find_all_by_merchant_id(0o000000)
  end

  def test_it_can_find_all_by_pending_status
    assert_equal 58, invoice_repo.find_all_by_status(:pending).count
  end

  def test_it_can_find_all_by_shipped_status
    assert_equal 120, invoice_repo.find_all_by_status(:shipped).count
  end

  def test_it_can_find_all_by_returned_status
    assert_equal 23, invoice_repo.find_all_by_status(:returned).count
  end

  def test_returns_empty_array_if_no_valid_statuses
    assert_equal [], invoice_repo.find_all_by_status('hello')
  end

  def test_it_can_find_max_id
    assert_equal 202, invoice_repo.find_max_id
  end

  def test_it_can_create_a_new_invoice
    assert_instance_of Invoice, invoice_repo.create(attrs)
  end
end
