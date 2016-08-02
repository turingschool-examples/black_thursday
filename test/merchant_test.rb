require_relative './test_helper'
require_relative '../lib/merchant'

class MerchantTest < Minitest::Test
  def test_it_has_id_and_name
    merchant = Merchant.new({:id => 4, :name => "Turing School"})

    assert_equal 4, merchant.id
    assert_equal "Turing School", merchant.name
  end

  def test_it_can_ask_merchant_repo_for_invoice
    mock_mr = Minitest::Mock.new
    merchant = Merchant.new({
      :id => 4,
      :name => "Turing School"},
      mock_mr)
    mock_mr.expect(:find_invoices_by_merchant_id, ["an array of merchants"], [4])
    assert_equal ["an array of merchants"], merchant.invoices
    assert mock_mr.verify
  end

  def test_merchant_has_customers
    mock_mr = Minitest::Mock.new 
    mock_invoice = Minitest::Mock.new 
    mock_invoice_2 = Minitest::Mock.new 
    m = Merchant.new({
      :id => 12334141,
      :name => "jejum"
      }, mock_mr)
    mock_mr.expect(:find_invoices_by_merchant_id, [mock_invoice, mock_invoice_2], [12334141])
    mock_invoice.expect(:customer_id, 7)
    mock_invoice_2.expect(:customer_id, 8)
    mock_mr.expect(:find_customer_by_customer_id, "a single customer", [7])
    mock_mr.expect(:find_customer_by_customer_id, "a different customer", [8])
    assert_equal ["a single customer", "a different customer"], m.customers
    assert mock_mr.verify
    assert mock_invoice.verify
  end
end
