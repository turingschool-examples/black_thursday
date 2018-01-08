require './test/test_helper'
require './lib/transaction'


class TransactionTest < MiniTest::Test

  def setup
    @transaction = Transaction.new({
      :id => 2213,
      :invoice_id => 3675,
      :credit_card_number => 4.76315E+15,
      :credit_card_expiration_date => 112,
      :result => "success",
      :created_at => "2012-02-26 20:58:09 UTC",
      :updated_at => "2012-02-26 20:58:09 UTC"
      })
  end

  def test_it_exists
    assert_instance_of Transaction, @transaction
  end

  def test_id_returns_integer
    assert_equal 2213, @transaction.id
  end

  def test_inovice_id_returns_invoice_as_integer
    assert_equal 3675, @transaction.invoice_id
  end

  def test_credit_card_number_returns_integer_with_zeros
    assert_equal 4763150000000000, @transaction.credit_card_number
  end

  def test_credit_card_exp_date_returns_string_with_zero_padding
    assert_equal "0112", @transaction.credit_card_expiration_date
  end

  def test_result_returns_symbol_string
    assert_equal "success", @transaction.result
  end

  def test_created_at_returns_time
    assert_instance_of Time, @transaction.created_at
  end


end
