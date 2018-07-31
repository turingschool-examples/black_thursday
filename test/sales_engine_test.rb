require 'simplecov'
SimpleCov.start

require 'minitest/pride'
require 'minitest/autorun'
require_relative '../lib/item'
require_relative '../lib/item_repository'
require_relative '../lib/merchant'
require_relative '../lib/merchant_repository'
require_relative '../lib/sales_analyst'
require_relative '../lib/invoice_item_repository'
require_relative '../lib/transaction_repository'
require_relative '../lib/transaction'
require_relative '../lib/customer_repository'
require_relative '../lib/customer'
require_relative '../lib/invoice'
require_relative '../lib/invoice_repository'
require_relative '../lib/sales_engine'
require_relative '../lib/math_helper'

class SalesEngineTest < Minitest::Test

  def setup
    @merchant_repository
    @sales_engine = SalesEngine.new
    @sales_engine.merchant_builder("id: 1")
  end

  def test_it_exists
    salesengine = SalesEngine.new
    assert_instance_of SalesEngine, salesengine
  end

  def test_it_can_return_a_merchant_repository
    se = SalesEngine.new
    se.merchant_builder(@merchant_data)
    assert_instance_of MerchantRepository, se.merchants
  end

  def test_it_can_return_an_item_repository
skip
  end

  def test_it_can_return_an_invoice_item_repository
skip
  end

  def test_it_can_return_a_transaction_repository
skip
  end

  def test_it_can_return_a_customer_repository
skip
  end

  def test_it_can_return_an_invoice_repository
    skip
  end

end
