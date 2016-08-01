require 'bigdecimal'
require "./test/test_helper"
require "./lib/invoice"
require "./lib/sales_engine"

class InvoiceTest < Minitest::Test
  def test_invoice_returns_the_id
    invoice = Invoice.new({id: "4"})
    assert_equal 4, invoice.id
  end

  def test_it_can_find_the_cutomer_id
    invoice = Invoice.new({customer_id: "1"})
    assert_equal 1, invoice.customer_id
  end

  def test_it_can_find_the_merchant_id
    invoice = Invoice.new({merchant_id: "12335938"})
    assert_equal 12335938, invoice.merchant_id
  end

  def test_it_can_find_the_status
    invoice = Invoice.new({status: "pending"})
    assert_equal :pending, invoice.status
  end

  def test_it_can_find_the_created_date
    time = Time.strptime("2013-08-05", "%Y-%m-%d")
    invoice = Invoice.new({created_at: "2013-08-05"})
    assert_equal time, invoice.created_at
  end

  def test_it_can_find_the_updated_date
    time = Time.strptime("2014-06-06", "%Y-%m-%d")
    invoice = Invoice.new({updated_at: "2014-06-06"})
    assert_equal time, invoice.updated_at
  end

  def test_merchant
    mock_ir = Minitest::Mock.new
    mock_ir.expect(:find_merchant_by_id, "instance of merchant", [12335938])
    invoice = Invoice.new({merchant_id: "12335938"}, mock_ir)
    assert_equal "instance of merchant", invoice.merchant
    mock_ir.verify
  end

  def test_items
    mock_ir = Minitest::Mock.new
    mock_ir.expect(:find_all_items_by_invoice_id, ["item1", "item2"], [4])
    invoice = Invoice.new({id: "4"}, mock_ir)
    assert_equal ["item1", "item2"], invoice.items
    mock_ir.verify
  end

  def test_transactions
    mock_ir = Minitest::Mock.new
    mock_ir.expect(:find_all_transactions_by_invoice_id, ["trans1", "trans2"], [4])
    invoice = Invoice.new({id: "4"}, mock_ir)
    assert_equal ["trans1", "trans2"], invoice.transactions
    mock_ir.verify
  end

  def test_customer
    mock_ir = Minitest::Mock.new
    mock_ir.expect(:find_customer_by_id, "instance of customer", [1])

    invoice = Invoice.new({customer_id: "1"}, mock_ir)
    assert_equal "instance of customer", invoice.customer
  end

  def test_total
    mock_ir = Minitest::Mock.new
    mock_item1 = Minitest::Mock.new
    mock_item2 = Minitest::Mock.new

    mock_ir.expect(:find_all_invoice_items_by_invoice_id, [mock_item1, mock_item2], [4])
    mock_item1.expect(:unit_price, BigDecimal.new(10))
    mock_item1.expect(:quantity, 2)
    mock_item2.expect(:unit_price, BigDecimal.new(15))
    mock_item2.expect(:quantity, 2)

    invoice = Invoice.new({id: "4"}, mock_ir)
    assert_equal 50, invoice.total
    mock_ir.verify
  end

  def test_paid_in_full
    mock_ir = Minitest::Mock.new
    mock_trans = Minitest::Mock.new
    mock_trans.expect(:result, "success")
    mock_ir.expect(:find_all_transactions_by_invoice_id, [mock_trans], [4])

    invoice = Invoice.new({id:"4"}, mock_ir)
    assert invoice.is_paid_in_full?
    assert mock_ir.verify
    assert mock_trans.verify
  end
end
