require_relative "test_helper"
require_relative "../lib/transaction_repository"

class TransactionRepositoryTest < Minitest::Test

  def test_it_exists
    parent = mock("parent")
    tr = TransactionRepository.new("./test/fixtures/transactions_fixture.csv", parent)

    assert_instance_of TransactionRepository, tr
  end

  def test_all_returns_array_of_all_transactions
    parent = mock("parent")
    tr = TransactionRepository.new("./test/fixtures/transactions_fixture.csv", parent)

    assert_instance_of Array, tr.all
    tr.all.each {|transaction| assert_instance_of Transaction, transaction}
    assert_equal 1, tr.all.first.id
    assert_equal 21, tr.all.last.id
  end

  def test_find_by_id_returns_nil_or_transaction_with_matching_id
    parent = mock("parent")
    tr = TransactionRepository.new("./test/fixtures/transactions_fixture.csv", parent)

    assert_nil tr.find_by_id(40)

    assert_equal 1, tr.find_by_id(1).id
  end

  def test_find_all_by_invoice_id_returns_all_matches_with_invoice_id
    parent = mock("parent")
    tr = TransactionRepository.new("./test/fixtures/transactions_fixture.csv", parent)

    assert_equal [], tr.find_all_by_invoice_id("a")
    assert_equal 18, tr.find_all_by_invoice_id(18).first.invoice_id
    assert_equal 2, tr.find_all_by_invoice_id(20).count
    tr.find_all_by_invoice_id(20).each { |t| assert_equal 20, t.invoice_id }
    assert_equal 3, tr.find_all_by_invoice_id(19).count
    tr.find_all_by_invoice_id(19).each { |t| assert_equal 19, t.invoice_id }
  end

  def test_find_all_by_credit_card_number_returns_all_transactions_w_matching_ccn
    parent = mock("parent")
    tr = TransactionRepository.new("./test/fixtures/transactions_fixture.csv", parent)

    assert_equal [], tr.find_all_by_credit_card_number("a")
    assert_equal 4558368405929183, tr.find_all_by_credit_card_number(4558368405929183).first.credit_card_number
    assert_equal 3, tr.find_all_by_credit_card_number(4890371279632775).count
    tr.find_all_by_credit_card_number(4297222478855497).each { |t| assert_equal 4297222478855497, t.credit_card_number }
  end

  def test_find_all_by_result_returns_all_transactions_w_matching_result
    parent = mock("parent")
    tr = TransactionRepository.new("./test/fixtures/transactions_fixture.csv", parent)

    assert_equal [], tr.find_all_by_result("a")
    assert_equal "success", tr.find_all_by_result("success").first.result
    assert_equal 17, tr.find_all_by_result("success").count
    tr.find_all_by_result("success").each { |t| assert_equal "success", t.result }
    assert_equal 4, tr.find_all_by_result("failed").count
    tr.find_all_by_result("failed").each { |t| assert_equal "failed", t.result}
  end

end
