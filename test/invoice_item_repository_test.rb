require 'minitest/autorun'
require 'minitest/pride'
require 'csv'
require 'time'
require 'pry'
require_relative '../lib/invoice_item_repository'
require_relative '../lib/sales_engine'

class InvoiceItemRepositoryTest < Minitest::Test
  def setup
    se = SalesEngine.from_csv({
            :merchants     => './fixtures/merchants_fixtures.csv',
            :items         => './fixtures/items_fixtures.csv',
            :invoices      => './fixtures/invoices_fixtures.csv',
            :invoice_items => './fixtures/invoice_items_fixtures.csv'
            })
    @ir = se.invoice_items
  end

  def test_all_returns_array_of_all_invoice_items
    all = @ir.all
    assert_equal 1, all[0].id
    assert_equal 2, all[1].id
    assert_equal 24, all.count
  end

  def test_find_by_id_returns_first_invoice_with_matching_id
    assert_equal 1, @ir.find_by_id(1).id
  end

  def test_find_by_id_returns_nil_if_id_does_not_exist
    assert_equal nil, @ir.find_by_id(567)
  end

  def test_find_all_by_item_id_returns_array_of_invoice_items_with_matching_item_ids
    all = @ir.find_all_by_item_id(263396013)
    assert_equal 1, all[0].id
    assert_equal 3, all[1].id
    assert_equal 5, all.count
  end

  def test_find_all_by_item_id_returns_empty_array_if_id_doesnt_match
    assert_equal [], @ir.find_all_by_item_id(143)
  end

  def test_find_all_by_invoice_id_returns_array_of_invoice_items_with_matching_id
    all = @ir.find_all_by_invoice_id(12)
    assert_equal 1, all[0].id
    assert_equal 3, all.count
  end

  def test_find_all_by_invoice_id_returns_empty_array_if_there_are_no_matches
    assert_equal [], @ir.find_all_by_invoice_id(123432324)
  end
end
