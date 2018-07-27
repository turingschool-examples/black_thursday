require_relative 'test_helper'
require_relative '../lib/transaction_repository'
require_relative '../lib/transaction'

class TransactionRepositoryTest < Minitest::Test
  def setup
    @transaction_1 = Transaction.new({:id => 6, :invoice_id => 8, :credit_card_number => "4242424242421111", :credit_card_expiration_date => "0220", :result => "success", :created_at => Time.now, :updated_at => Time.now})
    @transaction_2 = Transaction.new({:id => 7, :invoice_id => 9, :credit_card_number => "4242424242422222", :credit_card_expiration_date => "0321", :result => "success", :created_at => Time.now, :updated_at => Time.now})
    @transaction_3 = Transaction.new({:id => 8, :invoice_id => 10, :credit_card_number => "4242424242423333", :credit_card_expiration_date => "0422", :result => "success", :created_at => Time.now, :updated_at => Time.now})
    @transaction_4 = Transaction.new({:id => 9, :invoice_id => 11, :credit_card_number => "4242424242424444", :credit_card_expiration_date => "0523", :result => "success", :created_at => Time.now, :updated_at => Time.now})
    @transactions = [@transaction_1, @transaction_2, @transaction_3, @transaction_4]
    @transaction_repository = TransactionRepository.new(@transactions)
  end

  def test_it_exists
    assert_instance_of TransactionRepository, @transaction_repository
  end

  def test_it_returns_all_transactions
    assert_equal @transactions, @transaction_repository.all
  end

  def test_it_can_find_by_id
    assert_equal @transaction_1, @transaction_repository.find_by_id(6)
    assert_equal nil, @transaction_repository.find_by_id(8798798)
  end

  def test_it_can_find_all_by_invoice_id
    assert_equal [], @transaction_repository.find_all_by_invoice_id(37)
    assert_equal [@transaction_4], @transaction_repository.find_all_by_invoice_id(11)
  end

  def test_it_can_find_by_credit_card_number
    assert_equal [], @transaction_repository.find_all_by_credit_card_number("987987987")
    assert_equal [@transaction_3], @transaction_repository.find_all_by_credit_card_number("4242424242423333")
  end

  def test_it_can_find_all_by_result
    assert_equal [], @transaction_repository.find_all_by_result("card shut off")
    assert_equal @transactions, @transaction_repository.find_all_by_result("success")
  end

  def test_transaction_can_be_created
    @transaction_repository.create({:id => 6, :invoice_id => 8, :credit_card_number => "4242424242425555", :credit_card_expiration_date => "0720", :result => "success", :created_at => Time.now, :updated_at => Time.now})
    actual = @transaction_repository.all.last.id

    assert_equal 10, actual
    assert_equal 5, @transaction_repository.all.count
  end

  def test_it_can_be_updated
    original_time = @transaction_1.updated_at
    @transaction_repository.update(6, {:id => 6, :invoice_id => 8, :credit_card_number => "4242424242429999", :credit_card_expiration_date => "0223", :result => "bingo", :created_at => Time.now, :updated_at => Time.now})

    assert original_time < @transaction_1.updated_at

    actual = @transaction_repository.find_by_id(6).credit_card_number
    assert_equal "4242424242429999", actual

    actual = @transaction_repository.find_by_id(6).credit_card_expiration_date
    assert_equal "0223", actual

    actual = @transaction_repository.find_by_id(6).result
    assert_equal "bingo", actual
  end

  def test_transaction_can_be_deleted
    assert_equal 4, @transaction_repository.all.count
    @transaction_repository.delete(8)
    assert_equal 3, @transaction_repository.all.count
    assert_equal nil, @transaction_repository.find_by_id(8)
  end
end
