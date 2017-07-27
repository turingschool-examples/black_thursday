require 'minitest'
require 'minitest/autorun'
# require 'minitest/emoji'
require_relative '../lib/invoice_repository'

class InvoiceRepositoryTest < Minitest::Test
  def test_it_exists
    i = InvoiceRepository.new
    assert i
    assert_instance_of InvoiceRepository, i
  end
end
