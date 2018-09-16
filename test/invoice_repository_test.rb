require 'simplecov'
SimpleCov.start
require 'minitest/autorun'
require 'minitest/pride'
require 'pry'
require_relative '../lib/invoice_repository'
require_relative '../lib/invoice'

class InvoiceRepositoryTest<Minitest::Test

  def test_it_exists
    @ir = InvoiceRepository.new("./test/fixtures/merchants.csv")
    assert_instance_of InvoiceRepository, @ir
  end

end
