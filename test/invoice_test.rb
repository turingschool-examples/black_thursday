require 'time'

require './test/test_helper'
require './lib/invoice'
require './lib/item'
require './lib/customer'


class InvoiceTest < Minitest::Test

  def new_invoice(data)
    Fixture.new_record(:invoices, data)
  end

  def invoice_74
    Fixture.find_record(:invoices, 74)
  end

  def invoice_74_full
    Fixture.sales_engine(load_full_data: true).invoices.find_by_id(74)
  end

  def invoice_3737
    Fixture.find_record(:invoices, 3737)
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

  def test_merchant_returns_a_single_merchant
    assert_instance_of Merchant, invoice_74.merchant
  end

  def test_merchant_has_id_same_as_merchant_id
    assert_equal invoice_74_expected[:merchant_id], invoice_74.merchant.id
  end

  def test_transactions_returns_array_of_transactions_with_id_as_invoice_id
    transactions = invoice_74.transactions
    assert_instance_of Array, transactions
    refute transactions.empty?

    assert transactions.all? { |t| (t.is_a? Transaction) && t.invoice_id == 74 }
  end

  def test_items_returns_an_array_of_items
    items = invoice_74_full.items
    assert_instance_of Array, items
    refute items.empty?
    assert items.all? { |item| item.is_a? Item }
  end

  def test_items_are_always_connected_through_invoice_item
    engine = Fixture.sales_engine load_full_data: true
    invoice = engine.invoices.all.first
    items = invoice.items

    assert items.all? do |item|
      engine.invoice_items.find do |invoice_item|
        invoice_item.item_id == item.id &&
        invoice_item.invoice_id == invoice.id
      end
    end
  end

  def test_customer_returns_a_single_customer
    assert_instance_of Customer, invoice_74.customer
  end

  def test_customer_has_id_same_as_customer_id
    assert_equal invoice_74_expected[:customer_id], invoice_74.customer.id
  end

  def test_paid_in_full_returns_true_if_any_transaction_is_success
    assert invoice_74.is_paid_in_full?
  end

  def test_paid_in_full_returns_false_if_no_transactions_are_success
    refute invoice_3737.is_paid_in_full?
  end

  def test_paid_in_full_returns_false_if_none_exist
    invoice_blank = Fixture.find_record(:invoices, 170)
    refute invoice_blank.is_paid_in_full?
  end

  def test_total_only_returns_for_invoices_paid_in_full
    invoice_blank = Fixture.find_record(:invoices, 170)
    assert_equal 0, invoice_blank.total
  end

  def test_total_returns_the_revenue_for_the_total_transaction
    assert_equal BigDecimal.new("14496.62"), invoice_74.total
  end



end
