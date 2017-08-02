require './test/test_helper'
require './lib/transaction_repo'

class TransactionRepositoryTest < Minitest::Test

  def setup
    csvfile = CSV.open "./data/transactions.csv", headers: true, header_converters: :symbol
    @transaction_repo = TransactionRepository.new(csvfile, "engine")
  end

  def test_it_exist
    assert_instance_of TransactionRepository, @transaction_repo
  end

  def test_can_find_by_id
    id = 1
    invalid_id = 0

    assert_instance_of Transaction, @transaction_repo.find_by_id(id)
    assert_nil @transaction_repo.find_by_id(invalid_id)
  end
  #
  def test_can_find_all_by_invoice_id
    invoice_id = 2179

    assert_instance_of Array, @transaction_repo.find_all_by_invoice_id(invoice_id)
  end
  #
  def test_can_find_all_by_credit_card_number
    credit_card_number = "4068631943231473"

    assert_instance_of Array, @transaction_repo.find_all_by_credit_card_number(credit_card_number)
  end

  def test_can_find_all_by_result
    result = "success"

    assert_instance_of Array, @transaction_repo.find_all_by_result(result)
  end

end
