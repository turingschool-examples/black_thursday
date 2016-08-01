require './test/test_helper'
require './lib/customer'

class CustomerTest < Minitest::Test
  def test_it_has_appropriate_data
    c = Customer.new({
      :id => 1,
      :first_name => "Ghengis",
      :last_name => "Khan",
      :created_at => Time.now,
      :updated_at => Time.now
      })
    assert_equal 1, c.id
    assert_equal "Ghengis", c.first_name
    assert_equal "Khan", c.last_name
    assert_equal Time, c.created_at.class
    assert_equal Time, c.updated_at.class
  end

  def test_customer_has_merchants
    mock_cr = Minitest::Mock.new
    mock_invoice = Minitest::Mock.new
    mock_invoice_2 = Minitest::Mock.new
    c = Customer.new({
      :id => 1,
      :first_name => "Ghengis",
      :last_name => "Khan",
      :created_at => Time.now,
      :updated_at => Time.now
      }, mock_cr)
    mock_cr.expect(:find_invoices_by_customer_id, [mock_invoice, mock_invoice_2], [1])
    mock_invoice.expect(:merchant_id, 12)
    mock_invoice_2.expect(:merchant_id, 13)
    mock_cr.expect(:find_merchant_by_merchant_id, "a single merchant", [12])
    mock_cr.expect(:find_merchant_by_merchant_id, "a different merchant", [13])
    assert_equal ["a single merchant", "a different merchant"], c.merchants
    assert mock_cr.verify
    assert mock_invoice.verify
  end
end
