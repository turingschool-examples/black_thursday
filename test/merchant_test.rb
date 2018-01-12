require 'bigdecimal'
require_relative 'test_helper'
require_relative "../lib/merchant"


class MerchantTest < Minitest::Test

  attr_reader :merchant

  def setup
    merchant_data = {id: 23,
                     name: "Yonkers Bonkers Yo",
                     created_at: "2002-03-30"}
    parent = mock('repository')
    @merchant = Merchant.new(merchant_data, parent)
  end

  def test_it_exists
    assert_instance_of Merchant, @merchant
  end

  def test_it_has_attributes
    assert_equal 23, @merchant.id
    assert_equal "Yonkers Bonkers Yo", @merchant.name
    assert_equal Time.parse("2002-03-30"), @merchant.created_at
  end

  def test_it_grab_items_by_merchant_id
    item_1 = mock('Item')
    item_2 = mock('Item')
    item_3 = mock('Item')
    merchant.merchant_repo.stubs(:find_item).returns([item_1, item_2, item_3])

    assert_equal 3, @merchant.items.count
  end

  def test_it_grabs_all_invoices_by_merchant_id
    invoice_1 = mock('invoice_1')
    invoice_2 = mock('invoice_2')
    invoice_3 = mock('invoice_3')
    merchant.merchant_repo.stubs(:find_invoice).returns([invoice_1, invoice_2, invoice_3])

    assert_equal 3, merchant.invoices.count
    assert_equal [invoice_1, invoice_2, invoice_3], merchant.invoices
  end

  def test_it_grabs_all_customers
    c = mock('customer')
    c2 = mock('customer2')
    c3 = mock('customer3')
    invoice = stub(customer: c)
    invoice2 = stub(customer: c2)
    invoice3 = stub(customer: c3)
    merchant.merchant_repo.stubs(:find_invoice).returns([invoice, invoice2, invoice3])

    assert_equal [c, c2, c3], merchant.customers
  end

  def test_it_returns_revenue
    invoice_1 = stub(total: 2500,
                     is_paid_in_full?: true)
    invoice_2 = stub(total: 4500,
                     is_paid_in_full?: true)
    invoice_3 = stub(total: 4500,
                     is_paid_in_full?: false)
    merchant.merchant_repo.stubs(:find_invoice).returns([invoice_1, invoice_2, invoice_3])

    assert_equal 7000, merchant.revenue
  end

end
