require './test/test_helper'
require './lib/transaction'


class TransactionTest < MiniTest::Test

  def setup
    @transaction = Transaction.new({
      :id => 2213,
      :invoice_id => 3675,
      :credit_card_number => 4.76315E+15,
      :credit_card_experiation_date => 112,
      :result => "success",
      :created_at => "2012-02-26 20:58:09 UTC",
      :updated_at => "2012-02-26 20:58:09 UTC"
      })
  end

  def test_it_exists
    assert_instance_of Transaction, @transaction
  end

  def test_credit_card_number_returns
    assert_equal "4763150000000000", @transaction.credit_card_number
  end

end
