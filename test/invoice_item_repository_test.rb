require 'minitest'
require 'minitest/autorun'
require 'minitest/emoji'
require './lib/invoice_item_repository'

class InvoiceItemRepositoryTest < Minitest::Test

  def test_new_instance
    iir = InvoiceItemRepository.new("./test/data/invoice_items_fixture.csv", self)

    assert_instance_of InvoiceItemRepository, iir
  end

end
