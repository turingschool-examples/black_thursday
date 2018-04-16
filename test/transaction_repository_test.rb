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
    assert_equal '4068631943231473', actual.credit_card_number
  end

  def test_it_can_find_all_by_invoice_id
    actual = @tr.find_all_by_invoice_id(2179)
    assert_equal 1, actual[0].id

    actual = @tr.find_all_by_invoice_id(3560)
    assert_equal '4253041019870013', actual[0].credit_card_number

    actual = @tr.find_all_by_invoice_id(1496)
    assert_equal :success, actual[0].result
  end

  def test_it_can_find_all_by_credit_card_number
    actual = @tr.find_all_by_credit_card_number('4068631943231473')
    assert_equal :success, actual[0].result

    actual = @tr.find_all_by_credit_card_number('4253041019870013')
    assert_equal 3560, actual[0].invoice_id

    actual = @tr.find_all_by_credit_card_number('4068631943231473')
    assert_equal '0217', actual[0].credit_card_expiration_date
  end

  def test_it_can_find_all_by_result
    actual = @tr.find_all_by_result(:failed)
    assert_equal 14, actual[0].id

    actual = @tr.find_all_by_result(:success)
    assert_equal '0217', actual[0].credit_card_expiration_date
    assert_equal '4068631943231473', actual[1].credit_card_number
  end

  def test_it_can_find_highest_id
    actual = @tr.find_highest_id
    assert_equal 56, actual
  end

  def test_it_can_create_a_new_transaction
    actual = @tr.find_highest_id
    assert_equal 56, actual
    assert_equal :success, @tr.find_by_id(56).result
    attributes =  {
                  :invoice_id                   => 2124,
                  :credit_card_number           => '4840021010919095',
                  :credit_card_expiration_date  => '1219',
                  :result                       => :success,
                  :created_at                   => Time.now,
                  :updated_at                   => Time.now
                  }
    @tr.create(attributes)
    assert_equal 57, @tr.find_highest_id
    actual = @tr.find_by_id(57)
    assert_equal 2124, actual.invoice_id
    assert_equal '4840021010919095', actual.credit_card_number
  end

  def test_it_can_update_invoice_item
    actual = @tr.find_by_id(56)
    assert_equal '4068631943231473', actual.credit_card_number
    assert_equal Time.parse('2012-02-26 20:56:58 UTC'), actual.created_at
    assert_equal Time.parse('2012-02-26 20:56:58 UTC'), actual.updated_at
    attributes = {
      result: :failed
    }
    @tr.update(56, attributes)
    transaction = @tr.find_by_id(56)
    assert_equal :failed, transaction.result
  end

  def test_it_can_be_deleted
    transaction = @tr.find_by_id(56)
    assert_equal 1496, transaction.invoice_id
    @tr.delete(56)
    assert_nil @tr.find_by_id(56)
  end

end
