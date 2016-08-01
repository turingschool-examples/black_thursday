require_relative './test_helper'
require_relative '../lib/invoice_repo'

class InvoiceRepoTest < Minitest::Test
  def test_add_invoices_and_access_them
    ir = InvoiceRepo.new
    ir.add({:id => 1,
                    :customer_id => 250,
                    :merchant_id => 20,
                    :status => "shipped",
                    :created_at => Time.now,
                    :updated_at => Time.now})

    assert_equal 1, ir.all.count
    assert_equal :shipped, ir.all.first.status
  end

  def test_find_by_id
    ir = InvoiceRepo.new
    ir.add({:id => 25,
                    :customer_id => 405,
                    :merchant_id => 120,
                    :status => "shipped",
                    :created_at => Time.now,
                    :updated_at => Time.now})
    ir.add({:id => 45,
                    :customer_id => 290,
                    :merchant_id => 23})
    assert_equal 120, ir.find_by_id(25).merchant_id
  end

  def test_fail_at_find_by_id
    ir = InvoiceRepo.new
    ir.add({:id => 25,
                    :customer_id => 405,
                    :merchant_id => 120,
                    :status => "shipped",
                    :created_at => Time.now,
                    :updated_at => Time.now})
    ir.add({:id => 45,
                    :customer_id => 290,
                    :merchant_id => 23})
    assert_equal nil, ir.find_by_id(0)
  end

  def test_find_by_customer_id
    ir = InvoiceRepo.new
    ir.add({:id => 25,
                    :customer_id => 405,
                    :merchant_id => 120,
                    :status => "shipped",
                    :created_at => Time.now,
                    :updated_at => Time.now})
    ir.add({:id => 45,
                    :customer_id => 290,
                    :merchant_id => 23})
    assert_equal [], ir.find_all_by_customer_id(0)
    assert_equal 1, ir.find_all_by_customer_id(405).count
  end

  def test_find_all_by_merchant_id
    ir = InvoiceRepo.new
    ir.add({:id => 100,
                    :customer_id => 200,
                    :merchant_id => 300,
                    :status => "pending",
                    :created_at => Time.now,
                    :updated_at => Time.now})
    ir.add({:id => 1,
                    :customer_id => 2,
                    :merchant_id => 300})
    assert_equal [], ir.find_all_by_merchant_id(0)
    assert_equal 2, ir.find_all_by_merchant_id(300).count
  end

  def test_find_all_by_status
    ir = InvoiceRepo.new
    ir.add({:id => 100,
                    :customer_id => 200,
                    :merchant_id => 300,
                    :status => "pending",
                    :created_at => Time.now,
                    :updated_at => Time.now})
    ir.add({:id => 1,
                    :customer_id => 2,
                    :merchant_id => 300,
                    :status => "shipped"})
    ir.add({:id => 5,
                    :customer_id => 6,
                    :merchant_id => 7,
                    :status => "shipped"})
    assert_equal [], ir.find_all_by_status("no pay")
    assert_equal 2, ir.find_all_by_status("shipped").count
  end

  def test_it_can_ask_engine_for_invoice_merchant
    mock_se = Minitest::Mock.new
    ir = InvoiceRepo.new(mock_se)
    mock_se.expect(:find_merchant_by_merchant_id, nil, [1])
    ir.find_merchant_by_merchant_id(1)
    assert mock_se.verify
  end

  def test_it_passes_methods_getting_items_to_invoice
    mock_se = Minitest::Mock.new
    ir = InvoiceRepo.new(mock_se)
    mock_se.expect(:find_invoice_items_by_invoice_id, ["an array of invoice items"], [1])
    mock_se.expect(:find_item_by_item_id, "an item", [2])
    assert_equal ["an array of invoice items"], ir.find_invoice_items_by_invoice_id(1)
    assert_equal "an item", ir.find_item_by_item_id(2)
    assert mock_se.verify
  end

  def test_it_passes_methods_getting_transactions_to_invoice
    mock_se = Minitest::Mock.new
    ir = InvoiceRepo.new(mock_se)
    mock_se.expect(:find_transactions_by_invoice_id, "a transaction", [1])
    assert_equal "a transaction", ir.find_transactions_by_invoice_id(1)
    assert mock_se.verify
  end

  def test_it_passes_methods_getting_customer
    mock_se = Minitest::Mock.new
    ir = InvoiceRepo.new(mock_se)
    mock_se.expect(:find_customer_by_customer_id, "a customer", [10])
    assert_equal "a customer", ir.find_customer_by_customer_id(10)
    assert mock_se.verify
  end

end
