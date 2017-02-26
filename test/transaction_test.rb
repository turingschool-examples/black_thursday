require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/sales_engine'
require_relative '../lib/transaction'

class TransactionTest < Minitest::Test

  attr_reader :repo, :transaction


  def setup
    @transaction = Transaction.new({
      :id => 1,
      :invoice_id => 2179,
      :credit_card_number => 4068631943231473,
      :credit_card_expiration_date => "0217",
      :result => "success",
      :created_at => "2012-02-26",
      :updated_at => "20:56:56"
      }, repo)
  end

  def test_it_finds_the_expiration_date
    assert_equal "0217", transaction.credit_card_expiration_date
  end

end
