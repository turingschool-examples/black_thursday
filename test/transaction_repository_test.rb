require_relative './test_helper'

class TransactionRepositoryTest < Minitest::Test

  def test_it_exists
    tr = TransactionRepository.new('./test/data/transaction_sample.csv')
    assert_instance_of TransactionRepository, tr
  end

  def test_transaction_repo_has_repository_array_and_returns_all
    tr = TransactionRepository.new('./test/data/transaction_sample.csv')
    assert_equal 10, tr.all.count
    assert_instance_of Array, tr.all
  end

  def test_it_can_find_by_transaction_by_id
    tr = TransactionRepository.new('./test/data/transaction_sample.csv')
    result = tr.repo_array[1]
    assert_equal result, tr.find_by_id(2)
    assert_instance_of Transaction, tr.find_by_id(2)
  end

  def test_find_all_by_invoice_id
    tr = TransactionRepository.new('./test/data/transaction_sample.csv')
    assert_equal 1, tr.find_all_by_invoice_id(46).count
  end

  def test_find_all_by_credit_card_number
    tr = TransactionRepository.new('./test/data/transaction_sample.csv')
    assert_equal 1, tr.find_all_by_credit_card_number("4068631943231473").count
    assert_equal 0, tr.find_all_by_credit_card_number("4242424242424242").count
  end

  def test_find_all_by_transaction_result
    tr = TransactionRepository.new('./test/data/transaction_sample.csv')
    assert_equal 9, tr.find_all_by_result(:success).count
  end

  def test_merchant_repo_can_create_a_transaction
    tr = TransactionRepository.new('./test/data/transaction_sample.csv')
    attributes = {
     invoice_id: 8,
     credit_card_number: '4242424242424242',
     credit_card_expiration_date: '0220',
     result: 'success',
     created_at: Time.now,
     updated_at: Time.now
   }
   tr.create(attributes)
   transaction = tr.find_by_id(11)
   assert_equal 8, transaction.invoice_id
  end
  
  #
  # def test_we_can_update_attributes_for_customer
  #   cr = CustomerRepository.new('./test/data/customer_sample.csv')
  #   cr.create({:first_name => 'Larry'})
  #   cr.update(11, {:first_name => 'Larry',:last_name => 'Shiny', :updated_at => Time.now})
  #   updated_customer = cr.find_by_id(11)
  #   assert_equal 'Larry', updated_customer.first_name
  #   assert_equal 'Shiny', updated_customer.last_name
  #   assert_instance_of Time, updated_customer.updated_at
  # end



end
