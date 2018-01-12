require_relative 'test_helper'
require_relative "../lib/merchant"
require_relative "../lib/invoice"

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
    merchant.merchant_repo.stubs(:find_item).with(23).returns([item_1, item_2, item_3])

    assert_equal 3, @merchant.items.count
    merchant.items.each do |item|
      assert_instance_of Mocha::Mock, item
    end
  end

  def test_it_grabs_all_invoices_by_merchant_id
    invoice_1 = mock('invoice')
    merchant.merchant_repo.stubs(:find_invoice).with(23).returns([invoice_1, invoice_1, invoice_1])

    assert_equal 3, @merchant.invoices.count
    merchant.items.each do |item|
      assert_instance_of Mocha::Mock, item
    end
  end

  def test_it_grabs_all_customers
    customer_1 = mock('Invoice')
    customer_2 = mock('Invoice')
    customer_3 = mock('Invoice')
    merchant.merchant_repo.stubs(:find_invoice).with(23).returns([customer_1, customer_2, customer_3])

    assert_equal 3, @merchant.invoice.count
    merchant.items.each do |item|
      assert_instance_of Mocha::Mock, item
    end
  end

  def test_it_grabs_all_customers
    parent = mock('respository')
    merchant_1, merchant_2 = mock('merchant'), mock('merchant_2')
    invoice_1 = Invoice.new({id: 3,
                             customer_id: 34,
                             merchant_id: 23,
                             status: 'shipped',
                             created_at: "2007-03-30",
                             updated_at: "2010-10-23"}, parent)
    invoice_2 = Invoice.new({id: 2,
                             customer_id: 23,
                             merchant_id: 23,
                             status: 'pending',
                             created_at: "2010-03-30",
                             updated_at: "2010-05-30"}, parent)

    invoice_1.invoice_repo.stubs(:customer).with(34).returns([merchant_1, merchant_2])
    invoice_2.invoice_repo.stubs(:customer).with(23).returns([merchant_1, merchant_2])
    @merchant.merchant_repo.stubs(:find_invoice).with(23).returns([invoice_1, invoice_2])

    binding.pry

    assert_equal 2, @merchant.customers.flatten(1).count
  end

  def test_it_returns_revenue
    invoice_1 = mock('invoice')
    invoice_2 = mock('invoice')
    

    assert_equal 7, @merchant.merchant_repo.merchants.count
  end

end
