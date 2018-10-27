require './test/test_helper'
require './lib/transaction_repository'
require './lib/transaction'

class TransactionRepositoryTest < Minitest::Test

  def setup
    @tran_1 = Transaction.new({:id => 12,
      :invoice_id => 3345,
      :credit_card_number => 4068631943231473,
      :credit_card_expiration => 0217,
      :result => :success,
      :created_at => Time.now,
      :updated_at=> Time.now})

    @tran_2 = Transaction.new({:id => 13,
      :invoice_id => 335,
      :credit_card_number => 4068631940004734,
      :credit_card_expiration => 0217,
      :result => :failed,
      :created_at => Time.now,
      :updated_at=> Time.now})

    @tran_3 = Transaction.new({:id => 14,
      :invoice_id => 3345,
      :credit_card_number => 4068631943231473,
      :credit_card_expiration => 0217,
      :result => :success,
      :created_at => Time.now,
      :updated_at=> Time.now})

    @tr = TransactionRepository.new
    @tr.add_transaction(@tran_1)
    @tr.add_transaction(@tran_2)
    @tr.add_transaction(@tran_3)
  end

  def test_it_exists
    assert_instance_of TransactionRepository, @tr
  end

  def test_it_can_add_transaction
    assert_equal [@tran_1, @tran_2, @tran_3], @tr.all
  end

  def test_find_by_id
    assert_equal @tran_1, @tr.find_by_id(12)
    assert_nil @tr.find_by_id(243)
  end

  def test_find_all_by_invoice_id
    assert_equal [@tran_1, @tran_3], @tr.find_all_by_invoice_id(3345)
    assert_equal [], @tr.find_all_by_invoice_id(24)
  end

  def test_find_all_by_credit_card_number
    assert_equal [@tran_1, @tran_3], @tr.find_all_by_credit_card_number(4068631943231473)
    assert_equal [], @tr.find_all_by_credit_card_number(3)
  end

  def test_find_all_by_result
    assert_equal [@tran_2], @tr.find_all_by_result(:failed)
  end

  def test_it_can_create_transaction_with_attributes
    @tr.create({:invoice_id => 3345,
      :credit_card_number => 4068631943231473,
      :credit_card_expiration => 0217,
      :result => :success,
      :created_at => Time.now,
      :updated_at=> Time.now})
      assert_equal 15, @tr.all.last.id
  end

  def test_it_can_update
    assert_equal :failed, @tr.find_by_id(13).result
    attributes = {result: :success}
    @tr.update(13, attributes)
    assert_equal :success, @tr.find_by_id(13).result
  end

  def test_it_can_delete_transaction
    assert_equal @tran_1, @tr.find_by_id(12)
    @tr.delete(12)
    assert_nil @tr.find_by_id(12)
  end

end
