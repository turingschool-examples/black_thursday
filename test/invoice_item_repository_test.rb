require_relative 'test_helper'
require './lib/invoice_item_repository'
require './lib/invoice_item'
require 'bigdecimal'

class InvoiceItemRepositoryTest < Minitest::Test
  def setup
    @iir = InvoiceItemRepository.new

    @ii_1 = {
      :id => 6,
      :item_id => 6,
      :invoice_id => 3,
      :quantity => 1,
      :unit_price => BigDecimal.new(10.99, 4),
      :created_at => Time.now,
      :updated_at => Time.now
    }

    @ii_2 = {
      :id => 6,
      :item_id => 7,
      :invoice_id => 8,
      :quantity => 1,
      :unit_price => BigDecimal.new(9.99, 4),
      :created_at => Time.now,
      :updated_at => Time.now
    }

    @ii_3 = {
      :id => 6,
      :item_id => 7,
      :invoice_id => 8,
      :quantity => 1,
      :unit_price => BigDecimal.new(9.99, 4),
      :created_at => Time.now,
      :updated_at => Time.now
    }
  end

  def create_invoice_items
    @iir.create(@ii_1)
    @iir.create(@ii_2)
    @iir.create(@ii_3)
  end

  def test_it_exists
    assert_instance_of InvoiceItemRepository, @iir
  end

  def test_it_has_a_type
    assert_equal InvoiceItem, @iir.type
  end

  def test_it_has_an_attr_whitelist
    assert_equal [:quantity, :unit_price], @iir.attr_whitelist
  end

  def test_find_all_by_item_id_returns_empty_array_if_no_matches
    create_invoice_items

    assert_equal [], @iir.find_all_by_item_id(12)
  end

  def test_find_all_by_item_id_returns_matching_instances
    create_invoice_items

    expected = [InvoiceItem.new(@ii_2), InvoiceItem.new(@ii_3)]
    result = @iir.find_all_by_item_id(7)

    assert_equal expected, result
  end

  def test_find_all_by_invoice_id_returns_empty_array_if_no_matches
    create_invoice_items

    assert_equal [], @iir.find_all_by_invoice_id(12)
  end

  def test_find_all_by_invoice_id_returns_matching_instances
    create_invoice_items

    expected = [InvoiceItem.new(@ii_2), InvoiceItem.new(@ii_3)]
    result = @iir.find_all_by_invoice_id(8)

    assert_equal expected, result
  end
end
