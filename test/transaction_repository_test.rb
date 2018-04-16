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
      [:credit_card_expiration_date, '0217'],
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
      [:credit_card_expiration_date, '0217'],
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

  def test_it_holds_invoice_items
    @tr.repository.values.all? do |transaction|
      assert_instance_of Transaction, transaction
    end
    assert_instance_of Transaction, @tr.repository.values[0]
    assert_instance_of Transaction, @tr.repository.values[1]
  end

  def test_it_can_find_all
    @tr.all.all? do |transaction|
      assert_instance_of Transaction, transaction
    end
  end

  def test_can_find_by_id
    actual = @tr.find_by_id(1)
    assert_equal 2179, actual.invoice_id

    actual = @tr.find_by_id(14)
    assert_equal '1214', actual.credit_card_expiration_date

    actual = @tr.find_by_id(56)
    assert_equal 4068631943231473, actual.credit_card_number
  end

  def test_it_can_find_all_by_invoice_id
    actual = @iir.find_all_by_invoice_id(1)
    assert_equal 263519844, actual[0].item_id

    actual = @iir.find_all_by_invoice_id(2)
    assert_equal 6, actual[0].quantity

    actual = @iir.find_all_by_invoice_id(5)
    assert_equal BigDecimal.new(323.46, 5), actual[0].unit_price
  end


end
