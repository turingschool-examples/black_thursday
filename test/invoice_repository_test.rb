require 'simplecov'
SimpleCov.start
require 'minitest/autorun'
require 'minitest/pride'
require 'pry'
require_relative '../lib/invoice_repository'
require_relative '../lib/invoice'

class InvoiceRepositoryTest<Minitest::Test

  def setup
    @ir = InvoiceRepository.new("./test/fixtures/merchants.csv")
  end

  def test_it_exists
    assert_instance_of InvoiceRepository, @ir
  end

  def test_i_can_get_all_the_invoices_in_an_array
    assert_instance_of Array, @ir.all
    assert_equal 7, @ir.all.count
    assert @ir.all.all? { |invoice| invoice.is_a?(Invoice)}
  end


  def test_i_can_find_the_invoice_by_its_id
    actual = @ir.find_by_id(1)
    assert_instance_of Invoice, actual
    actual = @ir.find_by_id(93428394)
    assert_nil actual
  end

  def test_i_can_find_all_by_customer_id
    actual = @ir.find_all_by_customer_id(1)
    assert_instance_of Invoice, actual
    actual = @ir.find_all_by_customer_id(91328)
    assert [], actual
  end
  #
  # def test_i_can_find_all_by_merchant_id
  #   actual = @ir.find_by_merchant_id(12335938)
  #   assert_instance of Invice, actual
  # end

end
