require 'simplecov'
SimpleCov.start
require_relative '../lib/transaction_repository'
require 'minitest'
require 'minitest/autorun'
require 'minitest/emoji'

class TransactionRepositoryTest < Minitest::Test

  def test_it_exists
    repo = TransactionRepository.new
    assert_instance_of TransactionRepository, repo
  end

  def test_it_has_transactions
    repo = TransactionRepository.new
    assert_equal [], repo.transactions
  end

  def transaction1
    {
      :id => 1,
      :invoice_id => 11,
      :credit_card_number => "4141414141414141",
      :credit_card_expiration_date => "0211",
      :result => "success",
      :created_at => "2012-02-26 20:56:41 UTC",
      :updated_at => "2012-02-26 20:56:51 UTC"
    }
  end

  def transaction2
    {
      :id => 2,
      :invoice_id => 22,
      :credit_card_number => "4242424242424242",
      :credit_card_expiration_date => "0222",
      :result => "failure",
      :created_at => "2012-02-26 20:56:42 UTC",
      :updated_at => "2012-02-26 20:56:52 UTC"
    }
  end

  def transaction3
    {
      :id => 3,
      :invoice_id => 33,
      :credit_card_number => "4343434343434343",
      :credit_card_expiration_date => "0233",
      :result => "success",
      :created_at => "2012-02-26 20:56:43 UTC",
      :updated_at => "2012-02-26 20:56:53 UTC"
    }
  end

end
