require_relative 'test_helper'
require_relative './../lib/transaction'
require_relative './../lib/transaction_repository'
require_relative './../lib/sales_engine'

class TransactionRepositoryTest < Minitest::Test

  attr_reader :engine, :repository

  def setup
    @engine = SalesEngine.from_csv({
    items: "./test/fixtures/truncated_items.csv",
    merchants: "./test/fixtures/truncated_merchants.csv",
    transactions: "./test/fixtures/truncated_transactions"
                                  })

    @repository = TransactionRepository.new("./test/fixtures/truncated_transactions.csv", @engine)
  end

  def test_it_exists
    assert_instance_of TransactionRepository, repository
  end

  def test_it_has_correct_attributes
    assert_instance_of Transaction, repository.transactions.first
    assert_instance_of Array, repository.transactions
    assert_instance_of SalesEngine, repository.parent
  end

  def test_load_csv_can_load_file
    assert_instance_of CSV, repository.load_csv("./test/fixtures/truncated_transactions.csv")
  end

  def test_all_returns_all_transactions
    assert_instance_of Array, repository.all
    assert_equal 99, repository.all.length
    assert_instance_of Transaction, repository.all.first
    assert_instance_of Transaction, repository.all.last
  end

  def test_find_by_id
    assert_instance_of Transaction, repository.find_by_id(10)
    assert_equal 2179, repository.find_by_id(5).invoice_id
    assert_equal 'success', repository.find_by_id(1).result
  end

  def test_find_by_id_edge_cases
    assert_nil repository.find_by_id(nil)
    assert_nil repository.find_by_id([0,329,23099])
    assert_nil repository.find_by_id('239')
  end

  def test_find_all_by_invoice_id
    assert_equal 1, repository.find_all_by_invoice_id(46).length
    assert_equal Time.parse('2012-02-26 20:56:56 UTC'), repository.find_all_by_invoice_id(46).first.created_at
    assert_equal '4177816490204479', repository.find_all_by_invoice_id(46).first.credit_card_number
  end

  def test_find_all_by_invoice_id_for_multiple_matching_ids
    assert_equal 2, repository.find_all_by_invoice_id(3477).length
    assert_equal Transaction, repository.find_all_by_invoice_id(3477).first.class
    assert_equal Transaction, repository.find_all_by_invoice_id(3477).last.class
    assert_equal 24, repository.find_all_by_invoice_id(3477).first.id
    assert_equal 25, repository.find_all_by_invoice_id(3477).last.id
  end

  def test_find_all_by_invoice_id_edge_cases
    assert_equal [], repository.find_all_by_invoice_id(nil)
    assert_equal [], repository.find_all_by_invoice_id([0,329,23099])
    assert_equal [], repository.find_all_by_invoice_id('239')
  end

  def test_find_all_by_credit_card_returns_correct_transaction
    assert_equal 1, repository.find_all_by_credit_card('4257133712179878').length
    assert_equal Array, repository.find_all_by_credit_card('4257133712179878').class
    assert_equal Transaction, repository.find_all_by_credit_card('4257133712179878').first.class
  end

end
