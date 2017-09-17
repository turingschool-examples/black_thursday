require './test/test_helper'
require './lib/transacation_repository'

class TransactionRepositoryTest < Minitest::Test

  attr_reader :transaction_repo

   def setup
     @transaction_repo = Fixture.repo(:Transacation)
   end

   def test_that_an_instance_exits
     assert_instance_of TransactionRepository, transaction_repo
   end

   def test_all_returns_an_array_of_all_transaction_instances
     assert_instance_of Array, transaction_repo
     assert_instance_of Transaction, transaction_repo.all.first
   end

   def test_find_by_id_returns_nil_if_no_matching_id
     assert_nil transaction_repo.find_by_id("happy")
   end

   def test_find_by_id_returns_transaction_instance
     transaction = transaction_repo.find_by_id(1)
     assert_instance_of Transaction, transaction

     assert_equal 1, transaction.id
   end

   def test_find_all_by_invoice_id_returns_an_empty_array_with_no_match
     assert_equal [], transaction_repo.find_all_by_invoice_id(00)
   end

   def test_find_all_by_invoice_id_returns_all_that_match_the_id
     assert_equal 1, transaction_repo.find_all_by_invoice_id(2179).count
   end

   def test_find_all_by_credit_card_number_returns_an_empty_array_with_no_match
     assert_equal [], transaction_repo.find_all_by_credit_card_number(00)
   end

   def test_find_all_by_credit_card_number_returns_all_that_match_the_id
     assert_equal 3, transaction_repo.find_all_by_credit_card_number(4068631943231473).count
   end

   def test_find_all_by_result_returns_an_empty_array_with_no_match
     assert_equal [], transaction_repo.find_all_by_result("nil")
   end

   def test_find_all_by_result_returns_all_that_match_the_id
     assert_equal 3, transaction_repo.find_all_by_result('failed').count
   end
end
