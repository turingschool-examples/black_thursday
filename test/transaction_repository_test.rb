require 'minitest/autorun'
require 'time'
require 'minitest/pride'
require './lib/transaction_repository'

class TransactionRepositoryTest < Minitest::Test

  def setup
    @transaction1 = [
      [:id, '1'],
      [:invoice_id, '2179'],
      [:credit_card_number, '4068631943231473'],
      [:credit_card_expiration_date, '217'],
      [:result, 'success'],
      [:created_at, '2012-02-26 20:56:56 UTC'],
      [:updated_at, '2012-02-26 20:56:56 UTC']
      ]
    @transaction2 = [
      [:id, '14'],
      [:invoice_id, '3560'],
      [:credit_card_number, '4253041019870013'],
      [:credit_card_expiration_date, '1214'],
      [:result, 'failed'],
      [:created_at, '2012-02-26 20:56:57 UTC'],
      [:updated_at, '2012-02-26 20:56:57 UTC']
      ]
    @transaction3 = [
      [:id, '56'],
      [:invoice_id, '1496'],
      [:credit_card_number, '4068631943231473'],
      [:credit_card_expiration_date, '217'],
      [:result, 'success'],
      [:created_at, '2012-02-26 20:56:58 UTC'],
      [:updated_at, '2012-02-26 20:56:58 UTC']
      ]
    @transactions = [@transaction1, @transaction2, @transaction3]
    @tr = TransactionRepository.new(@transactions)
  end

  def test_it_exists
      assert_instance_of TransactionRepository, @tr
  end



end
