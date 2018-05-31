require './test/test_helper'
require './lib/transaction'
require './lib/transaction_repository'
require './lib/repository'
require 'time'
require 'pry'

class TransactionRepositoryTest < Minitest::Test
  def setup
    transaction_repo = TransactionRepository.new

    transaction_1 = ({
      id: "1",
      invoice_id: "2179",
      credit_card_number: "4068631943231473",
      credit_card_expiration_date: "0217",
      result: "success",
      created_at: "2012-02-26 20:56:56 UTC",
      updated_at: "2012-02-26 20:56:56 UTC"
    })

    transaction_2 = ({
      id: "2",
      invoice_id: "46",
      credit_card_number: ""4177816490204479"",
      credit_card_expiration_date: "0813",
      result: "success",
      created_at: "2012-02-26 20:56:56 UTC",
      updated_at: "2012-02-26 20:56:56 UTC"
    })

    transaction_3 = ({
      id: "3",
      invoice_id: "750",
      credit_card_number: "4271805778010747",
      credit_card_expiration_date: "1220",
      result: "success",
      created_at: "2012-02-26 20:56:56 UTC",
      updated_at: "2012-02-26 20:56:56 UTC"
    })

    transaction_repo.create(transaction_1)
    transaction_repo.create(transaction_2)
    transaction_repo.create(transaction_3)

    @tr = transaction_repo
  end

  def test_transaction_repository_exists
    assert_instance_of TransactionRepository, @tr
  end

  def test_all_returns_all_transactions_in_repository
    by_all = @tr.all

    assert_equal true, by_all.all? {|transaction| transaction.class == Transaction}
    assert_equal 3, by_all.size
  end

  def test_transaction_repository_can_find_transaction_by_id
    by_id = @tr.find_by_id(3)

    assert_equal 750, by_id.invoice_id
    assert_equal "1220", by_id.credit_card_expiration_date
    assert_equal @tr.members[2], by_id
  end

  def test_transaction_repository_can_find_all_by_invoice_id
    by_invoice_id =  @tr.find_all_by_invoice_id(2179)

    assert_equal 1, by_invoice_id[0].id
    assert_equal [@tr.members[0]], by_invoice_id
    assert_equal :success, by_invoice_id[0].result
  end

  def test_transaction_repository_can_find_all_by_credit_card_number
    by_credit_card_number = @tr.find_all_by_credit_card_number("4177816490204479")

    assert_equal [@tr.members[1]], by_credit_card_number
    assert_equal 2, by_credit_card_number[0].id
    assert_equal "0813", by_credit_card_number[0].credit_card_expiration_date
  end

  def test_transaction_repository_can_find_all_by_result
    by_result = @tr.find_all_by_result("success")

    assert_equal @tr.all, by_result
    assert_equal 3, by_result.size
    assert_equal true, by_result.all? {|transaction| transaction.result == :success}
  end

  def test_transaction_repository_can_create_new_transaction
    transaction_4 = ({
      id: "4",
      invoice_id: "4126",
      credit_card_number: "4048033451067370",
      credit_card_expiration_date: "0313",
      result: "success",
      created_at: "2012-02-26 20:56:56 UTC",
      updated_at: "2012-02-26 20:56:56 UTC"
    })

    @tr.create(transaction_4)

    assert_equal 4, @tr.members.size
    assert_instance_of Transaction, @tr.members[3]
  end

  def test_transaction_repository_can_update_a_transaction
    updated = @tr.update(1, ({result: "failure"}))

    assert_equal :failure, @tr.members[0].result
  end

  def test_transaction_repository_can_delete_transaction
    assert_equal 3, @tr.members.size

    @tr.delete(2)

    assert_equal 2, @tr.members.size
    assert_equal 3, @tr.members[1].id
  end
end
