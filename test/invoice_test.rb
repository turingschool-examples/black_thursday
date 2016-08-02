require_relative './test_helper'
require_relative '../lib/invoice'
require 'bigdecimal'

class InvoiceTest < Minitest::Test
  def test_initializing_with_a_hash
    invoice = Invoice.new({:status => "pending"})

    assert_equal :pending, invoice.status
  end

  def test_it_has_all_the_things
    invoice = Invoice.new({:id => 7, :customer_id => 5, :merchant_id => 12582467,
      :status => "shipped", :created_at => Time.now, :updated_at => Time.now})

      assert_equal 7, invoice.id
      assert_equal 5, invoice.customer_id
      assert_equal 12582467, invoice.merchant_id
      assert_equal :shipped, invoice.status
      assert_respond_to invoice, :created_at
      assert_respond_to invoice, :updated_at
  end

  def test_it_accepts_partial_data
    invoice = Invoice.new({:id => 1, :status => "pending"})
    assert_equal 1, invoice.id
    assert_equal :pending, invoice.status
    assert_equal 0, invoice.customer_id
  end

  def test_it_has_a_parent_reached_by_merchant_method
    mock_ir = Minitest::Mock.new
    invoice = Invoice.new({
      :id => 7,
      :customer_id => 5,
      :merchant_id => 1,
      :status => "shipped",
      :created_at => Time.now,
      :updated_at => Time.now
      }, mock_ir)
    mock_ir.expect(:find_merchant_by_merchant_id, "merchant", [1])
    result = invoice.merchant
    assert mock_ir.verify
    assert_equal "merchant", result
  end

  def test_it_has_items
    mock_ir = Minitest::Mock.new
    mock_invoice_item_1 = Minitest::Mock.new
    mock_invoice_item_2 = Minitest::Mock.new
    invoice = Invoice.new({
      :id => 7,
      :customer_id => 5,
      :merchant_id => 1,
      :status => "shipped",
      :created_at => Time.now,
      :updated_at => Time.now
      }, mock_ir)
    mock_ir.expect(:find_invoice_items_by_invoice_id, [mock_invoice_item_1, mock_invoice_item_2], [7])
    mock_invoice_item_1.expect(:item_id, 10)
    mock_invoice_item_2.expect(:item_id, 11)
    mock_ir.expect(:find_item_by_item_id, "an item", [10])
    mock_ir.expect(:find_item_by_item_id, "a different item", [11])
    assert_equal ["an item", "a different item"], invoice.items
    assert mock_ir.verify
    assert mock_invoice_item_1.verify
    assert mock_invoice_item_2.verify
  end

  def test_it_has_transactions
    mock_ir = Minitest::Mock.new
    invoice = Invoice.new({
      :id => 7,
      :customer_id => 5,
      :merchant_id => 1,
      :status => "shipped",
      :created_at => Time.now,
      :updated_at => Time.now
      }, mock_ir)
    mock_ir.expect(:find_transactions_by_invoice_id, ["an array of transactions"], [7])
    assert_equal ["an array of transactions"], invoice.transactions
    assert mock_ir.verify
  end

  def test_it_has_customers
    mock_ir = Minitest::Mock.new
    invoice = Invoice.new({
      :id => 7,
      :customer_id => 5,
      :merchant_id => 1,
      :status => "shipped",
      :created_at => Time.now,
      :updated_at => Time.now
      }, mock_ir)
    mock_ir.expect(:find_customer_by_customer_id, "a customer", [5])
    assert_equal "a customer", invoice.customer
    assert mock_ir.verify
  end

  def test_is_paid_in_full
    mock_ir = Minitest::Mock.new
    mock_transaction_1 = Minitest::Mock.new
    mock_transaction_2 = Minitest::Mock.new
    invoice = Invoice.new({
      :id => 7,
      :customer_id => 5,
      :merchant_id => 1,
      :status => "shipped",
      :created_at => Time.now,
      :updated_at => Time.now
      }, mock_ir)
    mock_ir.expect(:find_transactions_by_invoice_id, [mock_transaction_1, mock_transaction_2], [7])
    mock_transaction_1.expect(:result, "failed")
    mock_transaction_2.expect(:result, "success")
    assert_equal true, invoice.is_paid_in_full?
    assert mock_ir.verify
    assert mock_transaction_1.verify
    assert mock_transaction_2.verify
  end

  def test_invoice_total
    mock_ir = Minitest::Mock.new
    mock_invoice_item_1 = Minitest::Mock.new
    mock_invoice_item_2 = Minitest::Mock.new
    mock_item_1 = Minitest::Mock.new
    mock_item_2 = Minitest::Mock.new
    invoice = Invoice.new({
      :id => 7,
      :customer_id => 5,
      :merchant_id => 1,
      :status => "shipped",
      :created_at => Time.now,
      :updated_at => Time.now
      }, mock_ir)
    mock_ir.expect(:find_invoice_items_by_invoice_id, [mock_invoice_item_1, mock_invoice_item_2], [7])
    mock_invoice_item_1.expect(:unit_price, BigDecimal.new(10,4))
    mock_invoice_item_2.expect(:unit_price, BigDecimal.new(11.50,4))
    mock_invoice_item_1.expect(:quantity, 3)
    mock_invoice_item_2.expect(:quantity, 1)
    assert_equal 41.50, invoice.total
    assert mock_ir.verify
    assert mock_invoice_item_1.verify
    assert mock_invoice_item_2.verify
  end

end
