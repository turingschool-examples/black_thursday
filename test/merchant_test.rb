require_relative 'test_helper'
require_relative '../lib/merchant'

class MerchantTest < Minitest::Test
  def test_it_has_id
    m = Merchant.new({:id => 5, :name => "Turing School", created_at: Time.now.inspect}, mock('MerchantRepository'))

    assert_equal 5, m.id
  end

  def test_it_has_name
    m = Merchant.new({:id => 5, :name => "Turing School", created_at: Time.now.inspect}, mock('MerchantRepository'))

    assert_equal "Turing School", m.name
  end

  def test_it_finds_average_item_price
    m = Merchant.new({:id => 12334105, :name => "Shopin1901", created_at: Time.now.inspect}, mock('MerchantRepository'))
    item_1 = stub(:unit_price => 29.99)
    item_2 = stub(:unit_price => 9.99)
    item_3 = stub(:unit_price => 9.99)
    m.stubs(:items).returns([item_1, item_2, item_3])

    assert_equal 16.66, m.average_item_price
  end

  def test_it_calls_merchant_repository_to_return_array_of_all_items
    item = mock('item')
    mr = mock('MerchantRepository')
    mr.expects(:find_items_by_id).returns([item, item, item])
    m = Merchant.new({:id => 12334105, :name => "Shopin1901", created_at: Time.now.inspect}, mr)

    assert_equal [item, item, item], m.items
  end

  def test_it_calls_its_parent_to_find_its_invoices
    invoice = mock('invoice')
    mr = mock('MerchantRepository')
    mr.expects(:find_invoices_by_id).returns([invoice, invoice, invoice])
    m = Merchant.new({:id => 12334105, :name => "Shopin1901", created_at: Time.now.inspect}, mr)

    assert_equal [invoice, invoice, invoice], m.invoices
  end

  def test_it_finds_its_customers_from_its_invoices
    customer = mock('customer')
    invoice = stub(:customer => customer)
    mr = stub(:find_invoices_by_id => [invoice, invoice, invoice])
    m = Merchant.new({:id => 12334105, :name => "Shopin1901", created_at: Time.now.inspect}, mr)

    assert_equal [customer], m.customers
  end

  def test_revenue_returns_merchants_total_revenue
    invoice_1 = stub(:total => 13.00,
                     :is_paid_in_full? => true)
    invoice_2 = stub(:total => 15.00,
                     :is_paid_in_full? => true)
    mr = stub(:find_invoices_by_id => [invoice_1, invoice_2])
    m = Merchant.new({:id => 12334105, :name => "Shopin1901", created_at: Time.now.inspect}, mr)

    assert_equal 28.00, m.revenue
  end

  def test_pending_invoices_returns_whether_merchant_has_pending_invoices
    invoice_1 = stub(:is_paid_in_full? => true)
    invoice_2 = stub(:is_paid_in_full? => true)
    invoice_3 = stub(:is_paid_in_full? => false)
    mr_1 = stub(:find_invoices_by_id => [invoice_1, invoice_2])
    mr_2 = stub(:find_invoices_by_id => [invoice_1, invoice_2, invoice_3])
    m_1 = Merchant.new({:id => 12334105, :name => "Shopin1901", created_at: Time.now.inspect}, mr_1)
    m_2 = Merchant.new({:id => 22334105, :name => "Shopin1301", created_at: Time.now.inspect}, mr_2)

    refute m_1.pending_invoices?
    assert m_2.pending_invoices?
  end
end
