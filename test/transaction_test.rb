require_relative 'test_helper'
require_relative '../lib/transaction'
require_relative '../lib/sales_engine'

class TransactionTest < Minitest::Test

  def test_transaction_exists
    transaction = Transaction.new({
      :id => 23, :invoice_id => 2639, :credit_card_number => 4566763237167619,
      :credit_card_expiration_date => "0220", :result => "success",
      :created_at => "2012-02-26 20:56:57 UTC",
      :updated_at => "2012-02-26 20:56:57 UTC"
      }, self)

    assert_instance_of Transaction, transaction
  end

  def test_transaction_has_id
    transaction = Transaction.new({
      :id => 23, :invoice_id => 2639, :credit_card_number => 4566763237167619,
      :credit_card_expiration_date => "0220", :result => "success",
      :created_at => "2012-02-26 20:56:57 UTC",
      :updated_at => "2012-02-26 20:56:57 UTC"
      }, self)
    id = transaction.id

    assert_equal 23, id
  end

  def test_transaction_has_invoice_id
    transaction = Transaction.new({
      :id => 23, :invoice_id => 2639, :credit_card_number => 4566763237167619,
      :credit_card_expiration_date => "0220", :result => "success",
      :created_at => "2012-02-26 20:56:57 UTC",
      :updated_at => "2012-02-26 20:56:57 UTC"
      }, self)
    invoice_id = transaction.invoice_id

    assert_equal 2639, invoice_id
  end

  def test_transaction_has_credit_card_number
    transaction = Transaction.new({
      :id => 23, :invoice_id => 2639, :credit_card_number => 4566763237167619,
      :credit_card_expiration_date => "0220", :result => "success",
      :created_at => "2012-02-26 20:56:57 UTC",
      :updated_at => "2012-02-26 20:56:57 UTC"
      }, self)
    cc_num = transaction.credit_card_number

    assert_equal 4566763237167619, cc_num
  end

  def test_transaction_has_credit_card_expiration_date
    transaction = Transaction.new({
      :id => 23, :invoice_id => 2639, :credit_card_number => 4566763237167619,
      :credit_card_expiration_date => "0220", :result => "success",
      :created_at => "2012-02-26 20:56:57 UTC",
      :updated_at => "2012-02-26 20:56:57 UTC"
      }, self)
    cc_num_exp = transaction.credit_card_expiration_date

    assert_equal "0220", cc_num_exp
  end

  def test_transaction_has_result
    transaction = Transaction.new({
      :id => 23, :invoice_id => 2639, :credit_card_number => 4566763237167619,
      :credit_card_expiration_date => "0220", :result => "success",
      :created_at => "2012-02-26 20:56:57 UTC",
      :updated_at => "2012-02-26 20:56:57 UTC"
      }, self)
    result = transaction.result

    assert_equal "success", result
  end

  def test_transaction_has_created_at_date
    transaction = Transaction.new({
      :id => 23, :invoice_id => 2639, :credit_card_number => 4566763237167619,
      :credit_card_expiration_date => "0220", :result => "success",
      :created_at => "2012-02-26 20:56:57 UTC",
      :updated_at => "2012-02-26 20:56:57 UTC"
      }, self)
    created_at = transaction.created_at

    assert_instance_of Time, created_at
    assert_equal '2012-02-26 20:56:57 UTC', created_at.to_s
  end

  def test_transaction_has_updated_at_date
    transaction = Transaction.new({
      :id => 23, :invoice_id => 2639, :credit_card_number => 4566763237167619,
      :credit_card_expiration_date => "0220", :result => "success",
      :created_at => "2012-02-26 20:56:57 UTC",
      :updated_at => "2012-02-26 20:56:57 UTC"
      }, self)
    updated_at = transaction.updated_at

    assert_instance_of Time, updated_at
    assert_equal '2012-02-26 20:56:57 UTC', updated_at.to_s
  end

  def test_transaction_can_check_invoice
    se = SalesEngine.from_csv({
      :invoices => './data/invoices.csv',
      :transactions => './data/transactions.csv'
      })
    transactions = se.transactions
    transaction = transactions.find_by_id(4400)
    invoice = transaction.invoice

    assert_instance_of Invoice, invoice
  end

end
