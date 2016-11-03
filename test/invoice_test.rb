require_relative 'test_helper'
require_relative '../lib/invoice'
require 'bigdecimal'
require 'time'

class InvoiceTest < Minitest::Test

  def setup
    invoice_info_1 = ({
      :id          => "5",
      :customer_id => "12",
      :status      => "pending",
      :created_at  => "2016-11-01 11:38:28 -0600",
      :updated_at  => "2016-11-01 14:38:28 -0600",
      :merchant_id => "10"
    })
    invoice_info_2 = ({
      :id          => nil,
      :customer_id => nil,
      :status      => nil,
      :created_at  => "2016-11-01 11:38:28 -0600",
      :updated_at  => "2016-11-01 14:38:28 -0600",
      :merchant_id => nil
    })
    parent = Minitest::Mock.new
    @invoice1 = Invoice.new(invoice_info_1, parent)
    @invoice2 = Invoice.new(invoice_info_2, parent)
    @invoice3 = Invoice.new()
    @invoice4 = Invoice.new({})
  end

  def test_it_exists
    assert @invoice1
  end

  def test_merchant_calls_parent
    @invoice1.parent.expect(:find_invoice_for_id, nil, [10])
    @invoice1.invoice
    @invoice1.parent.verify
  end

  def test_it_initializes_item_id
    assert_equal 5, @invoice1.id
  end

  def test_it_initializes_customer_id
    assert_equal 12, @invoice1.customer_id
  end

  def test_it_initializes_the_status
    assert_equal "pending", @invoice1.status
  end

  def test_it_initializes_item_create_time
    expected = Time.parse("2016-11-01 11:38:28 -0600")
    assert_equal expected, @invoice1.created_at
  end

  def test_it_initializes_item_update_time
    expected = Time.parse("2016-11-01 14:38:28 -0600")
    assert_equal expected, @invoice1.updated_at
  end

  def test_it_initializes_item_merchant_id
    assert_equal 10, @invoice1.merchant_id
  end

  def test_it_returns_zero_if_there_is_no_id_given
    assert_equal 0, @invoice2.id
  end

  def test_it_returns_empty_string_if_there_is_no_status_is_given
    assert_equal "", @invoice2.status
  end

  def test_it_returns_zero_if_there_is_no_customer_id_given
    assert_equal 0, @invoice2.customer_id
  end

  def test_it_returns_zero_if_there_is_no_merchant_id_given
    assert_equal 0, @invoice2.merchant_id
  end

  def test_it_returns_blank_item_object_if_no_data_passed
    assert_equal Invoice, @invoice3.class
    assert_nil @invoice3.id
    assert_nil @invoice3.created_at
    assert_nil @invoice3.status
  end

  def test_it_returns_blank_item_object_if_empty_hash_passed
    assert_equal Invoice, @invoice4.class
    assert_nil @invoice4.customer_id
    assert_nil @invoice4.unit_price
    assert_nil @invoice4.merchant_id
  end
end
