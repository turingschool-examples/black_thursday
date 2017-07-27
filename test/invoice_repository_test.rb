require 'minitest/autorun'
require 'minitest/emoji'
require './lib/invoice_repository.rb'
require 'pry'

class InvoiceRepositoryTest < Minitest::Test

  def test_it_exists
    invoice = InvoiceRepository.new('./data/invoices.csv', self)

    assert_instance_of InvoiceRepository, invoice
  end
end