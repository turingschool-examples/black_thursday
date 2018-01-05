require_relative 'test_helper'
require_relative '../lib/transaction_repository'

class TransactionRepositoryTest < Minitest::Test
  def setup
    file_path = './test/fixtures/transactions_truncated.csv'
    @tr = TransactionRepository.from_csv(file_path)
  end

  def test_it_can_find_all_known_transactions
    transactions = @tr.all

    assert_equal 10, transactions.length
    assert transactions.all? do |transaction|
      transaction.class == Transaction
    end
  end

  def test_find_by_id_returns_a_transaction_with_a_matching_id
    transaction = @tr.find_by_id(234)

    assert_instance_of Transaction, transaction
    assert 234, transaction.id
  end
end

# all - returns an array of all known Transaction instances
# find_by_id - returns either nil or an instance of Transaction with a matching ID
# find_all_by_invoice_id - returns either [] or one or more matches which have a matching invoice ID
# find_all_by_credit_card_number - returns either [] or one or more matches which have a matching credit card number
# find_all_by_result - returns either [] or one or more matches which have a matching status
