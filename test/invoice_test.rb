# frozen_string_literal: true

require 'simplecov'
SimpleCov.start
require 'date'
require './lib/file_loader.rb'
require './lib/invoice.rb'
require 'minitest'
require 'minitest/autorun'
require 'minitest/emoji'
require 'ostruct'
require 'pry'

# Provides an API of the item repo for testings invoice class.
class MockInvoiceRepository
  def transaction
    OpenStruct.new(id: 2)
  end
end

#
class InvoiceTest < Minitest::Test
  INVOICE_BODY = {
    id: '2',
    customer_id: '1',
    merchant_id: '12334753',
    status: 'shipped',
    created_at: '2012-11-23',
    updated_at: '2013-04-14'
  }.freeze

  attr_reader :invoice

  def setup
    @invoice = Invoice.new(INVOICE_BODY, MockInvoiceRepository.new)
  end

  def test_invoice_exists
    assert_instance_of Invoice, invoice
  end

  def test_it_has_an_integer_id
    assert_equal 2, invoice.id
  end

  def test_it_has_customer_id
    assert_equal 1, invoice.customer_id
  end

  def test_it_returns_merchants_id
    assert_equal 12334753, invoice.merchant_id
  end

  def test_it_returns_a_status
    assert_equal :shipped, invoice.status
  end

  def test_it_returns_a_created_date
    expected = Time.parse('2012-11-23')
    assert_equal expected, invoice.created_at
  end

  def test_it_returns_an_updated_date
    expected = Time.parse('2013-04-14')
    assert_equal expected, invoice.updated_at
  end
end
