require "./test/test_helper"
require "./lib/transaction_repo"

class TransactionRepoTest < Minitest::Test
  #
  # def test_gets_back_an_array
  #   filepath = "./data/support/transactions_support.csv"
  #   transaction_repo = TransactionRepo.new
  #   assert_equal Array, transaction_repo.from_csv(filepath).class
  # end

  def test_it_can_find_all_the_of_the_transactions
    filepath = "./data/support/transactions_support.csv"
    transaction_repo = TransactionRepo.new(filepath)
    # transaction_repo.from_csv(filepath)
    assert_equal 100, transaction_repo.all.count
  end

  def test_it_can_find_a_customer_by_an_id
    filepath = "./data/support/transactions_support.csv"
    transaction_repo = TransactionRepo.new(filepath)
    # transaction_repo.from_csv(filepath)
    assert_equal 2179, transaction_repo.find_by_id(1).invoice_id
  end

  def test_it_can_find_one_invoice_id
    filepath = "./data/support/transactions_support.csv"
    transaction_repo = TransactionRepo.new(filepath)
    # transaction_repo.from_csv(filepath)
    assert_equal 1, transaction_repo.find_all_by_invoice_id(2494).count
  end

  def test_it_can_find_all_by_invoice_id
    filepath = "./data/support/transactions_support.csv"
    transaction_repo = TransactionRepo.new(filepath)
    # transaction_repo.from_csv(filepath)
    assert_equal 2, transaction_repo.find_all_by_invoice_id(33).count
  end

  def test_it_can_find_one_credit_card
    filepath = "./data/support/transactions_support.csv"
    transaction_repo = TransactionRepo.new(filepath)
    # transaction_repo.from_csv(filepath)
    assert_equal 1, transaction_repo.find_all_by_credit_card_number("4455102439190243").count
  end

  def test_it_can_find_a_matching_credit_card_number
    filepath = "./data/support/transactions_support.csv"
    transaction_repo = TransactionRepo.new(filepath)
    # transaction_repo.from_csv(filepath)
    assert_equal 2, transaction_repo.find_all_by_credit_card_number("0676").count
  end

  def test_it_can_find_all_transactions_by_result
    filepath = "./data/support/transactions_support.csv"
    transaction_repo = TransactionRepo.new(filepath)
    # transaction_repo.from_csv(filepath)
    assert_equal 77, transaction_repo.find_all_by_result("success").count
  end

end
