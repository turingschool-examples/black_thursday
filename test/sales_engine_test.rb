# frozen_string_literal: true

require 'csv'
require_relative 'test_helper'
require_relative '../lib/sales_engine'
require_relative '../lib/item_repo'

class SalesEngineTest < Minitest::Test
  attr_reader :sales_engine

  def setup
    item_path = './test/fixture_data/item_repo_fixture.csv'
    merchant_path = './test/fixture_data/merchant_repo_fixture.csv'
    invoice_path = './test/fixture_data/invoice_1.csv'
    path = { items: item_path, merchants: merchant_path,
             invoices: invoice_path }
    @sales_engine = SalesEngine.from_csv(path)
  end

  def test_it_exists
    assert_instance_of SalesEngine, sales_engine
  end

  def test_access_to_merchants
    assert_instance_of MerchantRepo, sales_engine.merchants
  end

  def test_access_to_items
    assert_instance_of ItemRepo, sales_engine.items
  end

  def test_access_to_invoices
    assert_instance_of InvoiceRepo, sales_engine.invoices
  end
end
