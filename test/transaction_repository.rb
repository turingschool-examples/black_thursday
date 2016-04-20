require_relative 'test_helper'
require_relative '../lib/transaction_repository'
require_relative '../lib/sales_engine'



class TransactionRepositoryTest < Minitest::Test

  def test_setup
    assert TransactionRepository.new.class
  end
end
