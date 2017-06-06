require_relative 'test_helper'
require_relative '../lib/invoice'
require_relative '../lib/invoice_repository'
require 'pry'

class InvoiceTest < Minitest::Test

  def test_new_instance
    ir = InvoiceRepository.new("./test/data/invoices_fixture.csv", self)

    assert_instance_of Invoice, ir.contents[1]
  end

  def test_return_id_integer
    ir = InvoiceRepository.new("./test/data/invoices_fixture.csv", self)

    assert_equal 12, ir.contents[12].id
  end

  def test_return_customer_id
    ir = InvoiceRepository.new("./test/data/invoices_fixture.csv", self)

    assert_equal 3, ir.contents[15].customer_id
  end

  def test_return_merchant_id
    ir = InvoiceRepository.new("./test/data/invoices_fixture.csv", self)

    assert_equal 12334208, ir.contents[30].merchant_id
  end

  def test_return_status
    ir = InvoiceRepository.new("./test/data/invoices_fixture.csv", self)

    assert_equal "shipped", ir.contents[15].status
  end

  def test_return_created_at
    ir = InvoiceRepository.new("./test/data/invoices_fixture.csv", self)

    assert_equal "2009-02-07 00:00:00 -0700", ir.contents[1].created_at.to_s
  end

  def test_return_updated_at
    ir = InvoiceRepository.new("./test/data/invoices_fixture.csv", self)

    assert_equal "2014-07-01 00:00:00 -0600", ir.contents[15].updated_at.to_s
  end

end
