require_relative 'test_helper'
require_relative '../lib/transaction_repository'
require_relative '../lib/transaction'

class TransactionRepositoryTest < Minitest::Test
  def setup
    @transation_item_1 = Transaction.new({:id => 6, :invoice_id => 8, :credit_card_number => "4242424242421111", :credit_card_expiration_date => "0220", :result => "success", :created_at => Time.now, :updated_at => Time.now})
    @transation_item_2 = Transaction.new({:id => 7, :invoice_id => 9, :credit_card_number => "4242424242422222", :credit_card_expiration_date => "0321", :result => "success", :created_at => Time.now, :updated_at => Time.now})
    @transation_item_3 = Transaction.new({:id => 8, :invoice_id => 10, :credit_card_number => "4242424242423333", :credit_card_expiration_date => "0422", :result => "success", :created_at => Time.now, :updated_at => Time.now})
    @transation_item_4 = Transaction.new({:id => 9, :invoice_id => 11, :credit_card_number => "4242424242424444", :credit_card_expiration_date => "0523", :result => "success", :created_at => Time.now, :updated_at => Time.now})
    @transaction_items = [@transaction_item_1, @transation_item_2, @transation_item_3, @transation_item_4]
    @transaction_item_repository = TransactionRepository.new(@transaction_items)
  end

  def test_it_exists
    assert_instance_of TransactionRepository, @transaction_item_repository
  end

  def test_it_returns_all_transactions
    assert_equal @transaction_items, @transaction_item_repository.all
  end

end
