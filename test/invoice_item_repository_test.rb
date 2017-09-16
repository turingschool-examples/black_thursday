require_relative 'test_helper'
require_relative '../lib/invoice_item_repository'
require_relative '../lib/sales_engine'


class InvoiceItemRepositoryTest < Minitest::Test

  def setup
    ii = InvoiceItemRepository.new

    ii.from_csv('./test/fixtures/invoice_items_fixture.csv')
    ii
  end

  def test_it_exists
    ii = setup

    assert_instance_of InvoiceItemRepository, ii
  end

  def test_it_displays_all
    ii = setup

    assert_equal 59, ii.all.count
  end

  def test_it_can_find_ii_by_id
    ii = setup

    assert_equal 10, ii.find_by_id(15303).quantity
  end

  def test_it_finds_all_with_given_id
    ii = setup

    assert_equal 1, ii.find_all_by_item_id(263403127).length
  end

  def test_it_finds_all_with_given_invoice_id
    ii = setup

    assert_equal 1, ii. find_all_by_invoice_id(621).length

  end
end
