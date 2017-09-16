require 'time'
require './test/test_helper'

require './lib/invoice'


class InvoiceTest < Minitest::Test

  def new_invoice(data)
    Fixture.new_record(:invoices, data)
  end

  def invoice_74
    Fixture.find_record(:invoices, 74)
  end

  def invoice_74_expected
    {
      id: 74,
      customer_id: 14,
      merchant_id: 12334105,
      status: :returned,
      created_at: Time.parse('2005-01-03'),
      updated_at: Time.parse('2005-04-20')
    }
  end



  def test_initialize_takes_a_hash_of_strings
    assert_instance_of Invoice, new_invoice({
      id: '1',
      customer_id: '1',
      merhcant_id: '1',
      status: 'pending',
      created_at: '2014-03-15',
      updated_at:'2017-03-15'
    })
  end

  def test_it_has_an_Integer_id
    assert_equal 74, invoice_74.id
  end

  def test_it_has_an_Integer_merchant_id
    assert_equal invoice_74_expected[:merchant_id], invoice_74.merchant_id
  end

  def test_it_has_an_Integer_customer_id
    assert_equal invoice_74_expected[:customer_id], invoice_74.customer_id
  end

  def test_it_has_a_Time_created_at
    assert_equal invoice_74_expected[:created_at], invoice_74.created_at
  end

  def test_it_has_a_Time_updated_at
    assert_equal invoice_74_expected[:updated_at], invoice_74.updated_at
  end

  def test_id_defaults_to_Integer
    invoice = new_invoice({
      customer_id: '1',
      merhcant_id: '1',
      status: 'pending',
      created_at: '2014-03-15',
      updated_at:'2017-03-15'
    })
    assert_instance_of Integer, invoice.id
  end

  def test_created_at_defaults_to_Time
    invoice = new_invoice({
      id: '1',
      customer_id: '1',
      merhcant_id: '1',
      status: 'pending',
      updated_at:'2017-03-15'
    })
    assert_instance_of Time, invoice.created_at
  end

  def test_updated_at_defaults_to_Time
    invoice = new_invoice({
      id: '1',
      customer_id: '1',
      merhcant_id: '1',
      status: 'pending',
      created_at: '2014-03-15'
    })
    assert_instance_of Time, invoice.created_at
  end

end
