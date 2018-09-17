require 'simplecov'
SimpleCov.start
require 'minitest/autorun'
require 'minitest/pride'
require 'pry'
require_relative '../lib/invoice_repository'
require_relative '../lib/invoice'
require_relative '../lib/black_thursday_helper'

class InvoiceRepositoryTest<Minitest::Test
  include BlackThursdayHelper

  def test_it_exists
    ir = InvoiceRepository.new("./test/fixtures/invoices.csv")
    assert_instance_of InvoiceRepository, ir
  end

  def test_i_can_get_all_the_invoices_in_an_array
    ir = InvoiceRepository.new("./test/fixtures/invoices.csv")
    assert_instance_of Array, ir.all
    assert_equal 4, ir.all.count
    assert ir.all.all? { |invoice| invoice.is_a?(Invoice)}
  end


  def test_i_can_find_the_invoice_by_its_id
    ir = InvoiceRepository.new("./test/fixtures/invoices.csv")
    actual = ir.find_by_id(1)
    assert_instance_of Invoice, actual
  end

  def test_it_returns_nil_if_no_invoice_found
    ir = InvoiceRepository.new("./test/fixtures/invoices.csv")
    actual = ir.find_by_id(93428394)
    assert_nil actual
  end

  def test_i_can_find_all_by_customer_id
    ir = InvoiceRepository.new("./test/fixtures/invoices.csv")
    actual = ir.find_all_by_customer_id(8)
    assert_equal [ir.all.first], actual
  end

  def test_i_can_find_all_by_merchant_id
    ir = InvoiceRepository.new("./test/fixtures/invoices.csv")
    actual = ir.find_all_by_merchant_id(34444)
    expected = [ir.all.first]
    assert_equal expected, actual
  end

  def test_i_can_find_all_by_status
    ir = InvoiceRepository.new("./test/fixtures/invoices.csv")
    actual = ir.find_all_by_status("pending")
    expected_one = ir.all.first
    expected_two = ir.all.last
    assert_equal [expected_one, expected_two], actual
  end

  def test_i_can_create_a_new_invoice_with_the_next_highest_id
    ir = InvoiceRepository.new("./test/fixtures/invoices.csv")
    actual = ir.create({:id => 99,
                        :cutomer_id => 77,
                        :merchant_id => 9384530,
                        :status => "shipped",
                        :created_at => Time.now,
                        :updated_at => Time.now})

    assert_instance_of Invoice, ir.find_by_id(5)
  end


  def test_i_can_update_an_existing_invoice
    ir = InvoiceRepository.new("./test/fixtures/invoices.csv")
    actual = ir.create({:id => 99,
                        :cutomer_id => 77,
                        :merchant_id => 9384530,
                        :status => "shipped",
                        :created_at => Time.now,
                        :updated_at => Time.now})
    ir.update(5, {:status =>"delivered, sucka"})
    expected = ir.find_by_id(5)

    assert_equal [expected], ir.find_all_by_status("delivered, sucka")
  end

  def test_i_can_delete_an_invoice_based_on_its_id
    ir = InvoiceRepository.new("./test/fixtures/invoices.csv")
    ir.delete(1)
    assert_nil ir.find_by_id(1)
  end

end
