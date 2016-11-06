require_relative 'test_helper'
require_relative '../lib/transaction_repository'

class TransactionRepositoryTest < Minitest::Test
  
   def setup
    parent = Minitest::Mock.new
    @transaction_repo = TransactionRepository.new('./data/test_transactions.csv', parent)
  end

  def test_it_exists
    assert TransactionRepository.new
  end

  def test_it_initializes_with_a_file
    assert TransactionRepository.new('./data/test_transactions.csv')
  end

  def test_it_has_custom_inspect
    assert_equal "#<TransactionRepository: 74 rows>", @transaction_repo.inspect
  end

  def test_find_invoice_by_id_calls_parent
    @transaction_repo.parent.expect(:find_invoice_by_id, nil, [8])
    @transaction_repo.find_invoice_by_id(8)
    @transaction_repo.parent.verify
  end

  def test_it_turns_file_contents_to_CSV_object
    assert_equal CSV, @transaction_repo.file_contents.class
  end

  def test_it_generates_array_of_transaction_objects_from_csv_object
    assert @transaction_repo.all.all?{|row| row.class == Transaction}
  end

  def test_find_by_id_returns_transaction_object_with_that_id
    transaction = @transaction_repo.find_by_id(3)
    assert transaction
    assert_equal Transaction, transaction.class
    assert_equal 3, transaction.id
  end

  def test_find_all_by_invoice_id_finds_all_transactions
    transactions = @transaction_repo.find_all_by_invoice_id(2179)
    assert transactions
    assert transactions.all? {|transaction| transaction.class == Transaction}
    assert transactions.all? {|transaction| transaction.invoice_id == 2179}
  end
  
  def test_find_all_by_credit_card_number_finds_all_transactions
    transactions = @transaction_repo.find_all_by_credit_card_number(4068631943231473)
    assert transactions
    assert transactions.all? {|transaction| transaction.class == Transaction}
    assert transactions.all? {|transaction| transaction.credit_card_number == 4068631943231473}
  end
  
  def test_find_all_by_result_finds_all_transactions
    transactions = @transaction_repo.find_all_by_result("success")
    assert transactions
    assert transactions.all? {|transaction| transaction.class == Transaction}
    assert transactions.all? {|transaction| transaction.result == "success"}
  end

end
