require_relative 'test_helper'

require_relative '../lib/sales_engine'
require_relative '../lib/transaction_repository'
require_relative '../lib/transaction'


class TransactionRepositoryTest < Minitest::Test

  def setup
    # these tests might break with specharness / require relative
    path = {:transactions => './data/transactions.csv'}
    @repo = SalesEngine.from_csv(path).transactions
    # # ===== Transaction Examples =================
    # id,invoice_id,credit_card_number,credit_card_expiration_date,result,created_at,updated_at
    # 1,2179,4068631943231473,0217,success,2012-02-26 20:56:56 UTC,2012-02-26 20:56:56 UTC
    # 2,46,4177816490204479,0813,success,2012-02-26 20:56:56 UTC,2012-02-26 20:56:56 UTC
    transaction_1_hash = { :"1" => { invocie_id:         "2179",
                                     credit_card_number: "4068631943231473",
                                     credit_card_expiration_date: "0217",
                                     result:             "success",
                                     created_at:         "2012-02-26 20:56:56 UTC",
                                     updated_at:         "2012-02-26 20:56:56 UTC"
                                     } }
    @key = transaction_1_hash.keys.first
    @values = transaction_1_hash.values.first
    # @transaction_1 = Transaction.new(@transaction_1_hash)
  end

  def test_it_exists
    assert_instance_of TransactionRepository, @repo
  end

  def test_it_gets_attributes
    # --- Read Only ---
    assert_instance_of Array, @repo.all
    assert_instance_of Transaction, @repo.all[0]
    assert_equal @repo.all.count, @repo.all.uniq.count
    assert_equal 4985, @repo.all.count
  end

  def test_it_makes_transactions
    # This test is skipped because it will affect other tests.
    skip
    @repo.make_transactions
    assert_equal 4985 * 2, @repo.all.count
  end

  def test_it_makes_a_formatted_hash
    # -- The new hash needs an additional column --
    new_column = {:id => 1}
    new_hash = new_column.merge(@values.dup)
    assert_equal new_hash, @repo.make_hash(@key, @values)
  end


  # --- Find By ---

  def test_it_can_find_by_transaction_id
    assert_nil @repo.find_by_id(000)
    found = @repo.find_by_id(1)
    assert_instance_of Transaction, found
    assert_equal 1, found.id
  end

  def test_it_can_find_all_transactions_by_invoice_id
    assert_equal [], @repo.find_all_by_invoice_id(000)
    found = @repo.find_all_by_invoice_id(2179)
    assert_instance_of Array, found
    assert_instance_of Transaction, found.first
    assert_equal 2179, found.first.invoice_id
  end

  def test_it_can_find_all_transactions_by_credit_card_number
    assert_equal [], @repo.find_all_by_credit_card_number(000)
    found = @repo.find_all_by_credit_card_number("4068631943231473")
    assert_instance_of Array, found
    assert_instance_of Transaction, found.first
    assert_equal "4068631943231473", found.first.credit_card_number
  end

  def test_it_can_find_all_transactions_by_result_status
    assert_equal [], @repo.find_all_by_result(000)
    found = @repo.find_all_by_result("success")
    assert_instance_of Array, found
    assert_instance_of Transaction, found.first
    assert_equal "success", found.first.result
  end

end
