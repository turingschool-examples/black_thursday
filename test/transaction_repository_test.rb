require_relative 'test_helper'
require_relative '../lib/transaction_repository'

class TransactionRepositoryTest < Minitest::Test
  def setup
    transaction_csv = './test/fixtures/transactions_list_truncated.csv'
    parent = 'parent'
    @tr = TransactionRepository.new(transaction_csv, parent)
  end

  def test_it_exists
    assert_instance_of TransactionRepository, @tr
    assert_equal 'parent', @tr.parent
  end

  def test_transactions_csv_parsed
    assert_equal 20, @tr.transactions.length
    assert_equal 1, @tr.transactions.first.id
  end
  #
  def test_all_transactions
    assert_equal 20, @tr.all.length
    assert @tr.all[3].is_a?(Transaction)
    assert_equal '4048033451067370', @tr.all[3].credit_card_number
  end
  #
  def test_find_by_id
    assert_nil @tr.find_by_id(35)
    assert_equal 547, @tr.find_by_id(16).invoice_id
  end

  def test_find_all_by_invoice_id
    assert_equal [], @tr.find_all_by_invoice_id(5)
    assert_equal '4890371279632775', @tr.find_all_by_invoice_id(2668).first.credit_card_number
  end

  def test_find_all_by_credit_card_number
    assert_equal [], @tr.find_all_by_credit_card_number(2345)
    assert_equal 18, @tr.find_all_by_credit_card_number('4055813232766404').first.id
  end
  #
  # def test_find_by_name
  #   assert_nil @ir.find_by_name('help meadsfadsf')
  #   assert_equal '510+ RealPush Icon Set', @ir.find_by_name('510+ RealPush Icon Set').name
  # end
  #
  # def test_find_all_with_description
  #   assert_equal [], @ir.find_all_with_description('help me')
  #   assert_equal 1, @ir.find_all_with_description('Free standing woo').length
  # end
  #
  # def test_find_all_by_price
  #   assert_equal [], @ir.find_all_by_price(111_245_6)
  #   assert_equal 7.00, @ir.find_all_by_price(7.00).first.unit_price_to_dollars
  # end
  #
  # def test_find_all_by_price_in_range
  #   assert_equal [], @ir.find_all_by_price_in_range(1..2)
  #   assert_equal 2, @ir.find_all_by_price_in_range(13.00..14.00).length
  # end
  #
  # def test_find_all_by_merchant_id
  #   assert_equal [], @ir.find_all_by_merchant_id(1)
  #   assert_equal 263_395_617, @ir.find_all_by_merchant_id(123_341_85).first.id
  #   assert_equal 263_396_013, @ir.find_all_by_merchant_id(123_341_85).last.id
  #   assert_equal 3, @ir.find_all_by_merchant_id(123_341_85).length
  # end
end
