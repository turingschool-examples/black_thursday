require_relative 'test_helper'
require 'csv'
require_relative './../lib/customer'
require_relative './../lib/customer_repository'

class CustomerTest < Minitest::Test
  attr_reader :repository

  def setup
    @engine = SalesEngine.from_csv(
      items: './test/fixtures/truncated_items.csv',
      merchants: './test/fixtures/truncated_merchants.csv',
      invoices: './test/fixtures/truncated_invoices.csv',
      transactions: './test/fixtures/truncated_transactions.csv',
      customers:
      './test/fixtures/truncated_customers.csv'
    )
    
    @repository = MerchantRepository.new("./test/fixtures/truncated_merchants.csv", @engine)
  end
end