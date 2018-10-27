require 'simplecov'
SimpleCov.start
require 'minitest/autorun'
require 'minitest/pride'
require './lib/invoice'
require './lib/invoice_repository'
require 'bigdecimal'
require 'time'

class InvoiceRepositoryTest < Minitest::Test

  def test_it_exists
    ir = InvoiceRepository.new("./data/invoices.csv")
    assert_instance_of InvoiceRepository, ir
  end

  def test_all_returns_array_of_all_invoices
    ir = InvoiceRepository.new("./data/invoices.csv")

    assert_instance_of Invoice, ir.all[0]
    assert_equal 4985, ir.all.count
  end

  def test_it_can_find_all_invoices_by_invoice_id
    ir = InvoiceRepository.new("./data/invoices.csv")
    assert_equal ir.all[3451], ir.find_by_id(3452)
  end

  def test_it_can_find_all_invoices_by_customer_id
    skip
    ir = InvoiceRepository.new("./data/invoices.csv")
    assert_equal ir.all[3452], ir.find_by_id(3452)
  end

  def test_it_can_find_all_invoices_by_merchant_id
    skip
  end

  def test_it_can_find_all_invoices_by_status
    skip
  end

  def test_that_it_can_create_an_invoice
    skip
    ir = InvoiceRepository.new("./data/invoices.csv")
    data = ({
      :name        => "Pencil",

    })
    actual = ir.create(data).last
    expected = ir.find_by_id(263567475)
    assert_equal expected, actual
  end

  def test_it_can_update_one_attribute_of_an_existing_invoice
    skip
    ir = InvoiceRepository.new("./data/invoices.csv")
    ir.update(263395721, {name: "Shopin2018"})
    updated_invoice = ir.all[2]
    assert_equal "Shopin2018" , updated_invoice.name
  end

  def test_it_can_delete_an_invoice
    skip
    ir = InvoiceRepository.new("./data/invoices.csv")
    ir.delete(263395721)
    assert_nil ir.find_by_id(263395721)
  end
end
