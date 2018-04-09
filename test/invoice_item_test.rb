# frozen_string_literal: true

require 'simplecov'
SimpleCov.start
require './lib/file_loader.rb'
require './lib/invoice_item.rb'
require './lib/item.rb'
require './lib/item_repository.rb'
require 'minitest'
require 'minitest/autorun'
require 'minitest/emoji'
require 'mocha/mini_test'
require 'ostruct'
require 'pry'

# Tests invoice item class and functionality with invoice item repo
class InvoiceItemTest < Minitest::Test
  INVOICE_ITEM_BODY = {
    id: '1',
    item_id: '263519844',
    invoice_id: '1',
    quantity: '5',
    unit_price: '13635',
    created_at: '2012-03-27 14:54:09 UTC',
    updated_at: '2012-03-27 14:54:09 UTC'
  }.freeze
end
