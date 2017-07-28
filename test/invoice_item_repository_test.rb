require 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/invoice_item_repository'


class InvoiceItemRepositoryTest < Minitest::Test
  def test_it_can_be_created
    ii = InvoiceItemRepository
  end

end
