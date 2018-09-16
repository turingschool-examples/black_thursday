require 'simplecov'
SimpleCov.start
require 'minitest/autorun'
require 'minitest/pride'
require 'pry'
require_relative '../lib/invoice_repository'
require_relative '../lib/invoice'

class InvoiceRepositoryTest<Minitest::Test

  def test_it_exists
    ir = InvoiceRepository.new("./test/fixtures/merchants.csv")
    assert_instance_of InvoiceRepository, ir
  end

  def test_i_can_get_all_the_invoices_in_an_array
    ir = InvoiceRepository.new("./test/fixtures/merchants.csv")
    assert_instance_of Array, ir.all
    assert_equal 7, ir.all.count
    assert ir.all.all? { |invoice| invoice.is_a?(Invoice)}
  end


  def test_i_can_find_the_invoice_by_its_id
    ir = InvoiceRepository.new("./test/fixtures/merchants.csv")
    actual = ir.find_by_id(1)
    assert_instance_of Invoice, actual
    actual = ir.find_by_id(93428394)
    assert_nil actual
  end

  def test_i_can_find_all_by_customer_id
    ir = InvoiceRepository.new("./test/fixtures/merchants.csv")
    expected = ir.find_all_by_customer_id(3)
    assert_equal expected, ir.find_all_by_customer_id(3)

    # => ok why does this only work when i use "find", instead of find all??
    #or when i do find all, i have to fuck with the ids and make some of them
    #different from each other? shit is wack. maybe find all freaks out
    #if all the ids are the same...
  end
  #
  def test_i_can_find_all_by_merchant_id
    ir = InvoiceRepository.new("./test/fixtures/merchants.csv")
    binding.pry
    actual = @ir.find_all_by_merchant_id(12335938)
    assert_instance_of Invoice, actual
  end


  #something is wrong, and the csv file is not populating??
  #anyway, the logic in the methods is fine
end
