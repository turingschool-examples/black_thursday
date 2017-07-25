require 'simplecov'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/invoice_item_repo'

class InvoiceItemRepositoryTest < Minitest::Test

  def test_it_exist
    invoice_item_repo = InvoiceItemRepository.new

    assert_instance_of InvoiceItemRepository, invoice_item_repo
  end

end
