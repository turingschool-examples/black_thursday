require './test/test_helper'

class TransactionRepositoryTest < Minitest::Test
  attr_reader :tr, :transaction_1, :transaction_2, :transaction_3, :transactions
  def setup
    @transaction_1 = Transaction.new(id: "1", invoice_id: "2179", credit_card_number: "4068631943231473", credit_card_expiration_date: "0217", result: "success", created_at: "2012-02-26 20:56:56 UTC", updated_at: "2012-02-26 20:56:56 UTC")
    @transaction_2 = Transaction.new(id: "10", invoice_id: "290", credit_card_number: "4149654190362629", credit_card_expiration_date: "0420", result: "success", created_at: "2012-02-26 20:56:57 UTC", updated_at: "2012-02-26 20:56:57 UTC")
    @transaction_3 = Transaction.new(id: "52", invoice_id: "413", credit_card_number: "4007233416896135", credit_card_expiration_date: "0513", result: "success", created_at: "2012-02-26 20:56:58 UTC", updated_at: "2012-02-26 20:56:58 UTC")
    @transactions = [transaction_1, transaction_2, transaction_3]
    @tr = TransactionRepository.new(transactions)
  end

  def test_trans_repo_exists
    assert_instance_of TransactionRepository, tr
  end

  def test_all
    assert_equal transactions, tr.all
  end

  def test_find_by_id
    assert_equal transaction_2, tr.find_by_id(10)
    assert_equal nil, tr.find_by_id(7)
  end

  def test_find_all_by_invoice_id
    assert_equal [transaction_3], tr.find_all_by_invoice_id(413)
    assert_equal [], tr.find_all_by_invoice_id(411234)
  end

  def test_find_all_by_credit_card_number
    assert_equal [transaction_1], tr.find_all_by_credit_card_number(4068631943231473)
    assert_equal [], tr.find_all_by_credit_card_number(4023458733231473)    
  end

  def test_find_all_by_result
    assert_equal [transaction_1, transaction_2, transaction_3], tr.find_all_by_result("success")
    assert_equal [], tr.find_all_by_result("fail")    
  end
end