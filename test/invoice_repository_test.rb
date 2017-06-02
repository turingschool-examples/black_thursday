require 'minitest/autorun'
require 'minitest/emoji'
require_relative '../lib/invoice_repository.rb'
require 'pry'

class InvoiceRepositoryTest < Minitest::Test

  def test_new_instance
    ir = InvoiceRepository.new("./test/data/invoices_fixture.csv", self)

    assert_instance_of InvoiceRepository, ir
  end

  def test_return_all_instances
    skip #need to figure out how to gather verification data
    ir = InvoiceRepository.new("./test/data/invoices_fixture.csv", self)

    assert_equal x, x
  end

  def test_return_instance_with_find_by_id_good_id
    ir = InvoiceRepository.new("./test/data/invoices_fixture.csv", self)
    actual = ir.find_by_id(30).id

    assert_equal 30, actual
  end

  def test_return_nil_with_find_by_id_bad_number
    ir = InvoiceRepository.new("./test/data/invoices_fixture.csv", self)

    assert_nil ir.find_by_id(3)
  end

  def test_return_find_all_by_customer_id_good_id
    ir = InvoiceRepository.new("./test/data/invoices_fixture.csv", self)
binding.pry
    actual = ir.find_all_by_customer_id(1)
    expected =

    assert_equal expected, actual
  end



end
