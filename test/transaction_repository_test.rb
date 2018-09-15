require_relative 'test_helper'

require './lib/transaction_repository'
require './lib/transaction'


class TransactionRepositoryTest < Minitest::Test

  def setup
    # these tests might break with specharness / require relative
    @path = './data/transactions.csv'
    @repo = TransactionRepository.new(@path)
    # CSV:
    # id,invoice_id,credit_card_number,credit_card_expiration_date,result,created_at,updated_at
    # 1,2179,4068631943231473,0217,success,2012-02-26 20:56:56 UTC,2012-02-26 20:56:56 UTC
    # @key = :"1"
    # @values = { :invoice_id                  => "2179"
    #             :credit_card_number          => "4068631943231473"
    #             :credit_card_expiration_date => "0217"
    #             :result                      => "success"
    #             :created_at                  => "2012-02-26 20:56:56 UTC"
    #             :updated_at                  => "2012-02-26 20:56:56 UTC"
    # }

  end

  def test_it_exists
    assert_instance_of TransactionRepository, @repo
  end

  def test_it_can_make_transactions
    trans = @repo.all.first(100)
    assert_instance_of Array, @repo.all
    assert_instance_of Transaction, @repo.all.last
    assert_equal 100, trans.count
    assert_equal 100, trans.uniq.count
    assert_equal 1, trans[0].id
    assert_equal 2179, trans[0].invoice_id
    assert_equal "4068631943231473", trans[0].credit_card_number
    assert_equal "0217", trans[0].credit_card_expiration_date
    assert_equal "success", trans[0].result
    assert_equal "2012-02-26 20:56:56 UTC", trans[0].created_at
    assert_equal "2012-02-26 20:56:56 UTC", trans[0].updated_at
  end

  def test_it_can_find_all
    assert_equal 4985, @repo.all.count
  end

end
