require 'test_helper'
require './lib/transaction_repository'

class TransactionRepositoryTest < Minitest::Test
  def test_transaction_repository_initalizes_with_attributes
    parent = mock('parent')
    transactions = TransactionRepository.new([
      {
        :id => 332211,
        :invoice_id => 12345,
        :credit_card_number => 1234567812345678,
        :credit_card_expiration_date => 0312,
        :result => "success",
        :created_at => "2017-11-03",
        :updated_at => "2017-11-04"
      },{
        :id => 443322,
        :invoice_id => 23456,
        :credit_card_number => 8765432187654321,
        :credit_card_expiration_date => 1111,
        :result => "failed",
        :created_at => "2010-11-01",
        :updated_at => "2017-12-02"
        }], parent)

    assert_instance_of TransactionRepository, transactions
    assert_equal 2, transactions.transactions.count
  end

end
