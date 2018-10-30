require 'simplecov'
SimpleCov.start
require 'minitest/autorun'
require 'minitest/pride'
require './lib/invoice_item_repository'

class InvoiceItemRepositoryTest < Minitest::Test

  def test_it_exists
    ii = InvoiceItemRepository.new('./data/invoice_items.csv')

    assert_instance_of InvoiceItemRepository, ii
  end
end
