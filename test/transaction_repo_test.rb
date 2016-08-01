require_relative './test_helper'
require_relative '../lib/transaction_repo'

class TransactionRepoTest < Minitest::Test
  def test_add_transactions_and_access_them
    tr = TransactionRepo.new
    tr.add({
       :id => 123,
       :invoice_id => 234,
       :credit_card_number => 4297222478855497,
       :result => "success",
       :unit_price => 50000,
       :created_at => Time.now,
       :updated_at => Time.now})
    assert_equal 1, tr.all.count
    assert_equal "success", tr.all.first.result
  end

  def test_find_by_id
    tr = TransactionRepo.new
    tr.add({
      :id => 123,
      :invoice_id => 234,
      :credit_card_number => 4297222478855497,
      :result => "success",
      :unit_price => 50000,
      :created_at => Time.now,
      :updated_at => Time.now})
    tr.add({
      :id => 400,
      :invoice_id => 678,
      :credit_card_number => 4297212378855497})
    assert_equal 234, tr.find_by_id(123).invoice_id
  end
  
  def test_find_all_by_invoice_id
    tr = TransactionRepo.new
    tr.add({
      :id => 123,
      :invoice_id => 234,
      :credit_card_number => 4297222478855497,
      :result => "success",
      :unit_price => 50000,
      :created_at => Time.now,
      :updated_at => Time.now})
    tr.add({
      :id => 400,
      :invoice_id => 789,
      :result => "success"})
    tr.add({
      :id => 250,
      :invoice_id => 789,
      :result => "pending"})
    found_transactions = tr.find_all_by_invoice_id(789)
    assert_equal 2, found_transactions.count 
    assert_equal 789, found_transactions.first.invoice_id
    assert_equal [], tr.find_all_by_invoice_id(1)
  end
  
  def test_find_all_by_credit_card_number
    tr = TransactionRepo.new
    tr.add({
      :id => 345,
      :invoice_id => 456,
      :credit_card_number => 4297222478855497,
      :result => "success",
      :unit_price => 10000,
      :created_at => Time.now,
      :updated_at => Time.now})
    tr.add({
      :id => 400,
      :invoice_id => 789,
      :credit_card_number => 4297222478855497,
      :result => "success"})
    tr.add({
      :id => 250,
      :invoice_id => 789,
      :result => "pending"})
    found_transactions = tr.find_all_by_credit_card_number(4297222478855497)
    assert_equal 2, found_transactions.count 
    assert_equal 4297222478855497, found_transactions.first.credit_card_number
    assert_equal [], tr.find_all_by_credit_card_number(1197222478855497)
  end
  
  def test_find_all_by_result
    tr = TransactionRepo.new
    tr.add({
      :id => 123,
      :invoice_id => 234,
      :credit_card_number => 4297222478855497,
      :result => "success",
      :unit_price => 50000,
      :created_at => Time.now,
      :updated_at => Time.now})
    tr.add({
      :id => 400,
      :invoice_id => 789,
      :result => "success"})
    tr.add({
      :id => 250,
      :invoice_id => 789,
      :result => "pending"})
    found_transactions = tr.find_all_by_result("success")
    assert_equal 2, found_transactions.count 
    assert_equal "success", found_transactions.first.result
    assert_equal [], tr.find_all_by_result("still waiting")
  end

  def test_passing_methods_to_sales_engine
    mock_se = Minitest::Mock.new
    tr = TransactionRepo.new(mock_se)
    mock_se.expect(:find_invoice_by_invoice_id, "invoice", [5] )
    assert_equal "invoice", tr.find_invoice_by_invoice_id(5)
    assert mock_se.verify
  end

end