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
    merchant = Merchant.new({:id => 4, :name => "Turing School"}, mock_mr)
    mock_mr.expect(:find_invoices_by_merchant_id, nil, [4])
    merchant.invoices
    assert mock_mr.verify
  end
end
