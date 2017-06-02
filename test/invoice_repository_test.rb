require 'minitest/autorun'
require 'minitest/emoji'
require_relative '../lib/invoice_repository.rb'
require 'pry'

class InvoiceRepositoryTest < Minitest::Test

  def test_new_instance
    ir = InvoiceRepository.new("./test/data/invoices_fixture.csv", self)

    assert_instance_of InvoiceRepository, ir
  end

end
