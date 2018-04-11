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
    id: '2'
    customer_id: '1'
    merchant_id: '12334753'
    status: 'shipped'
    created_at: '2012-11-23'
    updated_at: '2013-04-14'
  }.freeze

  attr_reader :invoice

  def setup
    @invoice = Invoice.new(INVOICE_BODY, MockInvoiceRepository.new)
  end
end
