require_relative 'test_helper'
require_relative '../lib/transaction_repository'


class TransactionRepositoryTest  < Minitest::Test

  def setup
    se = SalesEngine.from_csv({
      :transactions    => "./test/fixtures/transactions_fixture.csv"
      })
    se.transactions
  end

  def test_it_displays_all_its_transactions
    tr = setup

    assert_equal 29,tr.all.length
  end

  def test_it_finds_by_id
    tr = setup

    assert_equal 4988736743808526, tr.find_by_id(941).credit_card_number

  end

  def test_it_finds_all_by_invoice_id
    tr = setup

    assert_equal 2, tr.find_all_by_invoice_id(4085).count
  end

  def test_it_finds_all_by_credit_card_number
    tr = setup

    assert_equal 2, tr.find_all_by_credit_card_number(4134214819227763).count
  end

  def test_it_finds_all_by_result
    tr = setup

    assert_equal 26, tr.find_all_by_result(:success).count

  end
end
