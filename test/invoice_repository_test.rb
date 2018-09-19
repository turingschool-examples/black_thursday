require './test/helper'

class InvoiceRepositoryTest < Minitest::Test
  def setup
    se = SalesEngine.from_csv({
    :merchants     => './test/fixtures/merchants_fixtures.csv',
    :items         => './test/fixtures/items_fixtures.csv',
    :invoices      => './test/fixtures/invoices_fixtures.csv',
    :invoice_items => './test/fixtures/invoice_items_fixtures.csv'
                              })
    @invoices_r = se.invoices
  end

  def test_it_exists
    assert_instance_of InvoiceRepository, @invoices_r
  end

  def test_all_returns_an_array_of_all_invoices
    assert_equal 14, @invoices_r.all.count
  end

  def test_it_can_find_by_id
    result = @invoices_r.find_by_id(1)
    assert_equal 1, result.id
  end

  def test_it_can_find_all_by_cusomter_id
    result = @invoices_r.find_all_by_customer_id(2)
    assert_equal 4, result.count
    assert_equal 2, result.first.customer_id
  end

  def test_it_can_find_all_by_merchant_id
    result = @invoices_r.find_all_by_merchant_id(12336617)
    assert_equal 12336617, result.first.merchant_id
  end

  def test_it_can_find_all_by_status
    result = @invoices_r.find_all_by_status("pending")
    assert_equal 8, result.count
  end

  def test_it_can_create_new_invoice_with_attributes
    new_invoice = @invoices_r.create({customer_id: 2,
    merchant_id: 12334839, status: "pending"})
    assert_equal 12334839, new_invoice.merchant_id
    assert_equal 15, new_invoice.id
  end

  def test_attributes_can_be_updated
    @invoices_r.create({customer_id: 2, merchant_id: 12334839, status: "pending"})
    result = @invoices_r.update(15, {status: "shipped"})
    assert_equal "shipped", result.status
  end

  def test_it_can_be_deleted
    @invoices_r.create({customer_id: 2, merchant_id: 12334839, status: "pending"})
    assert_equal 15, @invoices_r.invoices.length
    @invoices_r.delete(15)
    assert_equal 14, @invoices_r.invoices.length
  end

end
