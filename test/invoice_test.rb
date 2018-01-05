require_relative '../lib/invoice'
require_relative '../test/test_helper'

class InvoiceTest < Minitest::Test

  def test_it_exists
    invoice = Invoice.new({ :id          => 6,
                            :customer_id => 7,
                            :merchant_id => 8,
                            :status      => "pending",
                            :created_at  => Time.now,
                            :updated_at  => Time.now })

    assert_instance_of Invoice, invoice
  end

  def test_it_has_id
    invoice = Invoice.new({ :id          => 6,
                            :customer_id => 7,
                            :merchant_id => 8,
                            :status      => "pending",
                            :created_at  => Time.now,
                            :updated_at  => Time.now })

    assert_equal 6, invoice.id
  end

  def test_it_has_customer_id
    invoice = Invoice.new({ :id          => 6,
                            :customer_id => 7,
                            :merchant_id => 8,
                            :status      => "pending",
                            :created_at  => Time.now,
                            :updated_at  => Time.now })

    assert_equal 7, invoice.customer_id
  end

  def test_it_has_merchant_id
    invoice = Invoice.new({ :id          => 6,
                            :customer_id => 7,
                            :merchant_id => 8,
                            :status      => "pending",
                            :created_at  => Time.now,
                            :updated_at  => Time.now })

    assert_equal 8, invoice.merchant_id
  end

  def test_it_has_status
    invoice = Invoice.new({ :id          => 6,
                            :customer_id => 7,
                            :merchant_id => 8,
                            :status      => "pending",
                            :created_at  => Time.now,
                            :updated_at  => Time.now })

    assert_equal "pending", invoice.status
  end

  def test_it_has_created_at
    invoice = Invoice.new({ :id          => 6,
                            :customer_id => 7,
                            :merchant_id => 8,
                            :status      => "pending",
                            :created_at  => "11:30:34",
                            :updated_at  => "18:17:19" })

    assert_equal "11:30:34", invoice.created_at
  end

  def test_it_has_updated_at
    invoice = Invoice.new({ :id          => 6,
                 :customer_id => 7,
                 :merchant_id => 8,
                 :status      => "pending",
                 :created_at  => "11:30:34",
                 :updated_at  => "18:17:19" })

    assert_equal "18:17:19", invoice.updated_at
  end

end
