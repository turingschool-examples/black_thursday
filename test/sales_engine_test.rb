#require 'simplecov'
#SimpleCov.start

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
    @sales_engine = SalesEngine.new

    @sales_engine.merchant_repository = @sales_engine.merchant_builder('./test/fixtures/merchants.csv')
  end

  def test_it_exists
    assert_instance_of SalesEngine, @sales_engine
  end

  def test_it_can_return_a_merchant_repository
    assert_instance_of MerchantRepository, @sales_engine.merchant_repository
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
