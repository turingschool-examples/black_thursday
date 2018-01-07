require_relative '../lib/invoice'
require_relative '../test/test_helper'

class InvoiceTest < Minitest::Test

  def test_it_exists
    parent = mock("parent")
    invoice = Invoice.new({ :id          => 6,
                            :customer_id => 7,
                            :merchant_id => 8,
                            :status      => "pending",
                            :created_at  => Time.now,
                            :updated_at  => Time.now },
                            parent)

    assert_instance_of Invoice, invoice
  end

  def test_it_has_id
    parent = mock("parent")
    invoice = Invoice.new({ :id          => 6,
                            :customer_id => 7,
                            :merchant_id => 8,
                            :status      => "pending",
                            :created_at  => Time.now,
                            :updated_at  => Time.now },
                            parent)

    assert_equal 6, invoice.id
  end

  def test_it_has_customer_id
    parent = mock("parent")
    invoice = Invoice.new({ :id          => 6,
                            :customer_id => 7,
                            :merchant_id => 8,
                            :status      => "pending",
                            :created_at  => Time.now,
                            :updated_at  => Time.now },
                            parent)

    assert_equal 7, invoice.customer_id
  end

  def test_it_has_merchant_id
    parent = mock("parent")
    invoice = Invoice.new({ :id          => 6,
                            :customer_id => 7,
                            :merchant_id => 8,
                            :status      => "pending",
                            :created_at  => Time.now,
                            :updated_at  => Time.now },
                            parent)

    assert_equal 8, invoice.merchant_id
  end

  def test_it_has_status
    parent = mock("parent")
    invoice = Invoice.new({ :id          => 6,
                            :customer_id => 7,
                            :merchant_id => 8,
                            :status      => "pending",
                            :created_at  => Time.now,
                            :updated_at  => Time.now },
                            parent)

    assert_equal :pending, invoice.status
  end

  def test_it_has_created_at
    parent = mock("parent")
    invoice = Invoice.new({ :id          => 6,
                            :customer_id => 7,
                            :merchant_id => 8,
                            :status      => "pending",
                            :created_at  => "2009-02-07",
                            :updated_at  => "2014-03-15" },
                            parent)

    assert_equal Time.parse("2009-02-07"), invoice.created_at
  end

  def test_it_has_updated_at
    parent = mock("parent")
    invoice = Invoice.new({ :id          => 6,
                            :customer_id => 7,
                            :merchant_id => 8,
                            :status      => "pending",
                            :created_at  => "2009-02-07",
                            :updated_at  => "2014-03-15" },
                            parent)

    assert_equal Time.parse("2014-03-15"), invoice.updated_at
  end

end
