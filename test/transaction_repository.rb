require './test/test_helper'
require './lib/sales_engine'
require './lib/transaction_repository'


class TransactionRepositoryTest < Minitest::Test

  def test_setup
    assert TransactionRepository.new.class
  end
end
