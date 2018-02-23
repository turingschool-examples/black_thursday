# frozen_string_literal: true

require_relative 'test_helper'

require_relative '../lib/transaction.rb'
require_relative '../lib/sales_engine'
require_relative 'mocks/test_engine'

class TransactionRepositoryTest < Minitest::Test
  def setup
    @invoice_repo = InvoiceRepository.new './test/fixtures/transactions.csv',
                                          MOCK_SALES_ENGINE
  end

  def test_creates_transaction_repository
    assert_instance_of TransactionRepository, @invoice_repo
  end
end
