require_relative 'test_helper'
require_relative '../lib/sales_engine'
require_relative '../lib/transaction_repository'
require 'pry'

class TransactionRepositoryTest < Minitest::Test

  def setup
    @sales_engine = SalesEngine.from_csv({
      :items => './test/fixtures/items_fixture.csv',
      :merchants => './test/fixtures/merchants.csv',
      :invoices => './test/fixtures/invoices.csv',
      :invoice_items => './test/fixtures/invoice_items.csv',
      :transactions => './test/fixtures/transactions.csv',
      :customers => './test/fixtures/customers.csv'})
    @transactions = @sales_engine.transactions
    @invoices = @sales_engine.invoices
  end

  def test_that_it_finds_all_transactions
    assert_equal @transactions.transactions, @transactions.all
  end

  def test_that_it_finds_transactions_by_id
    transaction1 = @transactions.all[0]

    assert_nil nil, @transactions.find_by_id(234433)
    assert_equal transaction1, @transactions.find_by_id(1)
  end

  def test_that_it_finds_all_by_invoice_id
    transaction1 = @transactions.all[48]
    transaction2 = @transactions.all[49]

    assert_equal ([]), @transactions.find_all_by_invoice_id(100)
    assert_equal [transaction1, transaction2],
                  @transactions.find_all_by_invoice_id(41)
  end

  def test_that_it_finds_all_by_credit_card_number
    transaction1 = @transactions.all[0]
    transaction2 = @transactions.all[1]

    assert_equal ([]), @transactions.find_all_by_credit_card_number(100)
    assert_equal [transaction1, transaction2],
                  @transactions.find_all_by_credit_card_number(4068631943231473)
  end

  def test_that_it_finds_all_by_result
    transaction1 = @transactions.all[8]
    transaction2 = @transactions.all[13]
    transaction3 = @transactions.all[17]
    transaction4 = @transactions.all[20]
    transaction5 = @transactions.all[25]
    transaction6 = @transactions.all[29]
    transaction7 = @transactions.all[35]
    transaction8 = @transactions.all[36]
    transaction9 = @transactions.all[41]
    transaction10 = @transactions.all[48]
    result = [transaction1, transaction2, transaction3,
              transaction4, transaction5, transaction6,
              transaction7, transaction8, transaction9, transaction10,]

    assert_equal ([]), @transactions.find_all_by_result("succsailed")
    assert_equal result, @transactions.find_all_by_result("failed")
  end

  def test_that_it_finds_invoice_by_transaction_id
    invoice1 = @invoices.all[0]

    assert_equal invoice1, @transactions.find_invoice(1)
  end

end
