require 'minitest/autorun'
require 'minitest/pride'

require 'pry'

require './lib/transaction_repository'
require './lib/transaction'
require './lib/finder'


class TransactionRepositoryTest < Minitest::Test

  def setup
    # these tests might break with specharness / require relative
    @path = './data/transactions.csv'
    @repo = TransactionRepository.new(@path)
  end

  def test_it_exists
    assert_instance_of TransactionRepository, @repo
  end 

  def test_it_can_make_transactions
    trans = @repo.all.first(100)
    assert_equal 100, trans.count
    assert_equal 100, trans.uniq.count
    assert_equal 1, trans[0].id
    assert_equal "2179", trans[0].invoice_id
    assert_equal "4068631943231473", trans[0].credit_card_number
    assert_equal "0217", trans[0].credit_card_expiration_date
    assert_equal "success", trans[0].result
    assert_equal "2012-02-26 20:56:56 UTC", trans[0].created_at
    assert_equal "2012-02-26 20:56:56 UTC", trans[0].updated_at
  end 

  def test_it_can_find_all
    assert_equal 9970, @repo.all.count
  end

end