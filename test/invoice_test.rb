require './test/test_helper'

require './lib/invoice'


class InvoiceTest < Minitest::Test

  def setup
    @se = sales_engine
  end

  def invoice(id = 1)
    @se.invoices.find_by_id(id)
  end

  def test_initialize_takes_a_hash_of_strings
    assert_instance_of Invoice, invoice
  end

  def test_it_has_an_Integer_id
    assert_same 2, invoice(2).id
  end

  def test_it_has_an_Integer_merchant_id
    assert_same 3, invoice.merchant_id
  end

  def test_it_has_an_Integer_customer_id
    assert_same 4, invoice.merchant_id
  end

  def test_it_has_a_Time_created_at
    assert_equal Time.new(given[:created_at]), invoice.created_at
  end

  def test_it_can_be_told_created_at
    assert_equal "", invoice.created_at
  end

  def test_it_has_a_Time_updated_at
    assert_equal Time.new(given[:updated_at]), invoice.updated_at
  end


  def test_merchant_returns_a_single_merchant
    assert_instance_of Merchant, invoice.merchant
  end

  def test_merchant_has_id_same_as_merchant_id
    assert_equal invoice.merchant_id, invoice.merchant.id
  end

end
