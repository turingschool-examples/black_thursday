# frozen_string_literal: true

require 'simplecov'
SimpleCov.start
require './lib/invoice_item_repository.rb'
require './lib/sales_engine.rb'
require 'minitest'
require 'minitest/autorun'
require 'minitest/emoji'
require 'pry'

# Tests the functionality of the invoice item repository
class InvoiceItemRepositorytest < Minitest::Test
  attr_reader :invoice_items

  def setup
    se = SalesEngine.from_csv({:invoice_items => './fixtures/invoice_items_test.csv'})
    @invoice_items = se.invoice_items
  end

  def test_invoice_item_repo_exists
    assert_instance_of InvoiceItemRepository, invoice_items
  end
end
