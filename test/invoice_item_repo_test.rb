require 'minitest/autorun'
require 'minitest/pride'
require './lib/invoice_item_repo'

class InvoiceItemRepo < Minitest::Test
  def setup
    @ii_repo = InvoiceItemRepository.new
  end

  def test_it_exists
    assert_instance_of InvoiceItemRepository, @ii_repo
  end
end
