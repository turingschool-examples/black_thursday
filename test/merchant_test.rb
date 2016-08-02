require './test/test_helper'
require './lib/merchant'
require 'csv'

class MerchantTest < Minitest::Test
  attr_reader :merchant_rows, :merchant_1

  def setup
    fixture = CSV.open('./test/fixtures/merchants_fixture.csv',
                          headers:true,
                          header_converters: :symbol)
    @merchant_rows = fixture.to_a
    @merchant_1 = Merchant.new(merchant_rows[0])
  end

  def test_has_name
    assert_equal "adam's bar", merchant_1.name
  end

  def test_has_fixnum_id
    assert_equal 1000, merchant_1.id
  end

  def test_method_items_queries_parent
    mock_mr = Minitest::Mock.new
    merchant = Merchant.new({id: 1}, mock_mr)
    mock_mr.expect(:find_all_items_by_merchant_id, nil, [1])
    merchant.items
    assert mock_mr.verify
  end

  def test_method_invoices_queries_parent
    mock_mr = Minitest::Mock.new
    merchant = Merchant.new({id: 1}, mock_mr)
    mock_mr.expect(:find_all_invoices_by_merchant_id, nil, [1])
    merchant.invoices
    assert mock_mr.verify
  end

  def test_method_customers_queries_parent
    mock_mr = Minitest::Mock.new
    merchant = Merchant.new({id: 1}, mock_mr)
    mock_mr.expect(:find_all_customers_by_merchant_id, nil, [1])
    merchant.customers
    assert mock_mr.verify
  end


end
