require 'minitest/autorun'
require 'minitest/emoji'
require_relative '../lib/invoice'
require_relative '../lib/invoice_repository'
require 'pry'

class InvoiceTest < Minitest::Test

  def test_new_instance
    ir = InvoiceRepository.new("./test/data/invoices_fixture.csv", self)

    assert_instance_of Invoice, ir.contents["1"]
  end

  def test_return_id_integer
    ir = InvoiceRepository.new("./test/data/invoices_fixture.csv", self)

    assert_equal 12, ir.contents["12"].id
  end

  def test_return_customer_id
    ir = InvoiceRepository.new("./test/data/invoices_fixture.csv", self)

    assert_equal "3", ir.contents["15"].customer_id
  end

end
