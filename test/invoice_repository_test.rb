require_relative '../lib/invoice_repository'
require_relative '../lib/invoice'
require_relative '../lib/sales_engine'
require_relative './test_helper'

class InvoiceRepositoryTest <Minitest::Test
  def test_it_exists
    se = SalesEngine.from_csv({:invoices => "./short_tests/short_invoice.csv"})
    invoice = se.invoices

    assert_instance_of SalesEngine, se
    assert_instance_of InvoiceRepository, invoice
  end

  def test_all_returns_array
    se = SalesEngine.from_csv({:invoices => "./short_tests/short_invoice.csv"})
    invoice = se.invoices

    assert_instance_of Array, invoice.all
  end

  def test_it_can_find_by_id
    se = SalesEngine.from_csv({:invoices => "./short_tests/short_invoice.csv"})
    invoice = se.invoices.find_by_id(10)

    assert_equal 2, invoice.customer_id
    assert_equal 12334839, invoice.merchant_id
  end

  def test_it_can_find_all_by_customer_id
    se = SalesEngine.from_csv({:invoices => "./short_tests/short_invoice.csv"})
    invoice = se.invoices

    i1 = invoice.find_by_id(1)
    i2 = invoice.find_by_id(2)
    i3 = invoice.find_by_id(3)
    i4 = invoice.find_by_id(4)
    i5 = invoice.find_by_id(5)
    i6 = invoice.find_by_id(6)
    i7 = invoice.find_by_id(7)
    i8 = invoice.find_by_id(8)
    i9 = invoice.find_by_id(9)
    i10 = invoice.find_by_id(10)

    assert_equal [i1,i2,i3,i4,i5,i6,i7,i8], invoice.find_all_by_customer_id(1)
    assert_equal [i9,i10], invoice.find_all_by_customer_id(2)
  end

  def test_it_can_find_all_by_merchant_id
    se = SalesEngine.from_csv({:invoices => "./short_tests/short_invoice.csv"})
    invoice = se.invoices

    i5 = invoice.find_by_id(5)

    assert_equal [i5], invoice.find_all_by_merchant_id(12335311)
    assert_equal [], invoice.find_all_by_merchant_id(1)
  end

  def test_it_can_find_all_by_status
    se = SalesEngine.from_csv({:invoices => "./short_tests/short_invoice.csv"})
    invoice = se.invoices

    i1 = invoice.find_by_id(1)
    i2 = invoice.find_by_id(2)
    i3 = invoice.find_by_id(3)
    i4 = invoice.find_by_id(4)
    i5 = invoice.find_by_id(5)
    i6 = invoice.find_by_id(6)
    i7 = invoice.find_by_id(7)
    i8 = invoice.find_by_id(8)
    i9 = invoice.find_by_id(9)
    i10 = invoice.find_by_id(10)

    assert_equal [i1,i4,i5,i6,i7,i10], invoice.find_all_by_status(:pending)
  end

def test_it_can_create_new_invoice_from_attributes
  se = SalesEngine.from_csv({:invoices => "./short_tests/short_invoice.csv"})
  invoice = se.invoices

  attributes = {customer_id: 2, merchant_id: 12337139, status: "pending", created_at: "2016-01-11 12:29:33 UTC", updated_at: Time.now}

  invoice.create(attributes)

  assert_equal 2, invoice.repo[-1].customer_id
  assert_equal 11, invoice.repo[-1].id
  assert_equal 12337139, invoice.repo[-1].merchant_id
end

end
