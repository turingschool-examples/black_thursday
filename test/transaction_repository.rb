require './test/test_helper'
require './lib/transaction_repository'
require './lib/sales_engine'



class TransactionRepositoryTest < Minitest::Test

  def test_setup
    assert TransactionRepository.new.class
  end
end
