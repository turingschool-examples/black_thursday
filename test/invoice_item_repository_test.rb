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

  def test_it_can_find_all
    assert_equal 3, invoice_items.all.length
  end

  def test_it_returns_nil_for_invalid_id
    expected = invoice_items.find_by_id(5)

    assert_nil expected
  end

  def test_it_returns_nil_or_instance_of_invoice_item_by_id
    expected = invoice_items.find_by_id(1)

    assert_equal 1, expected.id
    assert_equal 263519844, expected.item_id
  end

  def test_it_finds_invoice_item_by_item_id
  end
end
