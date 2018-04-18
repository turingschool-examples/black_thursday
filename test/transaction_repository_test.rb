require 'time'
require_relative 'test_helper'
require_relative '../lib/file_io'
require_relative '../lib/elementals/transaction'
require_relative '../lib/repositories/transaction_repository'

# Test for the TransactionRepository class
class TransactionRepositoryTest < Minitest::Test
  def setup
    csv = parse_data(transactions)
    @t_repo = TransactionRepository.new(csv)
    @transaction1 = @t_repo.transactions[1]
    @transaction2 = @t_repo.transactions[2]
    @transaction3 = @t_repo.transactions[3]
    @transaction4 = @t_repo.transactions[4]
  end

  def test_it_exists
    assert_instance_of TransactionRepository, @t_repo
  end

  def test_creating_an_index_of_transactions_from_data
    expected = { 1 => @transaction1, 2 => @transaction2,
                 3 => @transaction3, 4 => @transaction4 }
    assert_equal expected, @t_repo.transactions
  end

  def test_all_returns_an_array_of_all_transaction_instances
    assert_equal [@transaction1, @transaction2,
                  @transaction3, @transaction4], @t_repo.all
  end

  def test_can_find_by_id
    assert_equal @transaction1, @t_repo.find_by_id(1)
    assert_equal @transaction2, @t_repo.find_by_id(2)
  end

  def test_can_find_all_by_invoice_id
    actual = @t_repo.find_all_by_invoice_id(750)
    assert_equal [@transaction3, @transaction4], actual
  end

  def test_can_find_all_by_credit_card_number
    actual = @t_repo.find_all_by_credit_card_number('4271805778010747')
    assert_equal [@transaction3, @transaction4], actual
  end

  def test_can_find_all_by_credit_card_exp_date
    actual = @t_repo.find_all_by_credit_card_expiration_date('0217')
    assert_equal [@transaction1], actual
  end

  def test_can_find_all_by_result
    actual_success = @t_repo.find_all_by_result(:success)
    actual_failed = @t_repo.find_all_by_result(:failed)
    assert_equal [@transaction1, @transaction2, @transaction3], actual_success
    assert_equal [@transaction4], actual_failed
  end

  def test_it_can_generate_next_transaction_id
    assert_equal 5, @t_repo.create_new_id
  end

  def test_can_create_new_transaction
    a_new_transaction = new_transaction
    assert_equal 5, @t_repo.transactions.count
    assert_equal a_new_transaction, @t_repo.transactions[5]
  end

  def test_transaction_can_be_updated
    attrs = { credit_card_number: 4271805778010747,
              credit_card_expiration_date: '0210',
              result: 'failed' }
    @t_repo.update(4, attrs)
    assert_equal 4271805778010747, @t_repo.transactions[4].credit_card_number
    assert_equal '0210', @t_repo.transactions[4].credit_card_expiration_date
    assert_equal :failed, @t_repo.transactions[4].result
  end

  def test_transaction_can_be_deleted
    @t_repo.delete(4)
    assert_equal 3, @t_repo.transactions.count
    assert_nil @t_repo.transactions[4]
  end

  def new_transaction
    @t_repo.create(
      invoice_id: 621,
      credit_card_number: '4271805778010747',
      credit_card_expiration_date: '0217',
      result: :success,
      created_at: '2009-12-09 12:08:04 UTC',
      updated_at: '2010-12-09 12:08:04 UTC'
    )
  end

  def transactions
    %(id,invoice_id,credit_card_number,credit_card_expiration_date,result,created_at,updated_at
    1,2179,4068631943231473,0217,success,2012-02-26 20:56:56 UTC,2012-02-26 20:56:56 UTC
    2,46,4177816490204479,0813,success,2012-02-26 20:56:56 UTC,2012-02-26 20:56:56 UTC
    3,750,4271805778010747,1220,success,2012-02-26 20:56:56 UTC,2012-02-26 20:56:56 UTC
    4,750,4271805778010747,0124,failed,2012-02-26 20:56:56 UTC,2012-02-26 20:56:56 UTC)
  end

  def parse_data(data)
    CSV.parse(data, headers: :true, header_converters: :symbol)
  end
end
