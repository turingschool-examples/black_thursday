require 'time'
require './test/test_helper'

require './lib/invoice'


class InvoiceTest < Minitest::Test

  def setup
    @se = sales_engine
  end

  def find_invoice(id = 1)
    Fixture.record(:invoices, id)
  end

  def new_invoice(data)
    Fixture.new_record(data)
  end

  def invoice_1_data(field)
    {
      id: 1,
      merchant_id: 12335938,
      customer_id: 1,
      status: :pending,
      created_at: Time.parse('2009-02-07'),
      updated_at: Time.parse('2014-03-15')
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
    assert_same 2, find_invoice(2).id
  end

  def test_it_has_an_Integer_merchant_id
    assert_same invoice_1_data[:merchant_id], invoice.merchant_id
  end

  def test_it_has_an_Integer_customer_id
    assert_same invoice_1_data[:customer_id], invoice.customer_id
  end

  def test_it_has_a_Time_created_at
    assert_same invoice_1_data[:created_at], invoice.created_at
  end

  def test_it_has_a_Time_created_at
    assert_same invoice_1_data[:updated_at], invoice.updated_at
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
