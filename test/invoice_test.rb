require_relative './test_helper'
require_relative '../lib/invoice'

class InvoiceTest < Minitest::Test
  def test_initializing_with_a_hash
    invoice = Invoice.new({:status => "pending"})

    assert_equal "pending", invoice.status
  end

  def test_it_has_all_the_things
    invoice = Invoice.new({:id => 7, :customer_id => 5, :merchant_id => 12582467,
      :status => "shipped", :created_at => Time.now, :updated_at => Time.now})

      assert_equal 7, invoice.id
      assert_equal 5, invoice.customer_id
      assert_equal 12582467, invoice.merchant_id
      assert_equal "shipped", invoice.status
      assert_respond_to invoice, :created_at
      assert_respond_to invoice, :updated_at
  end

  def test_it_accepts_partial_data
    invoice = Invoice.new({:id => 1, :status => "pending"})
    assert_equal 1, invoice.id
    assert_equal "pending", invoice.status
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

end
