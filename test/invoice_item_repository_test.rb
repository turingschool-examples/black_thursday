require_relative './test_helper'
require 'bigdecimal'
require 'time'
require './lib/invoice_item'
require './lib/invoice_item_repository'
require 'mocha/minitest'

class InvoiceItemRepositoryTest < Minitest::Test

  def setup
    @ii = InvoiceItemRepository.new("./fixture_data/invoice_items_sample.csv", "engine")
  end

  def test_it_exists_and_has_attributes
    assert_instance_of InvoiceItemRepository, @ii
  end

  def test_it_can_create_items_from_csv
    assert_equal 584, @ii.all.count
  end

  def test_it_finds_by_id
    item = @ii.all.first

    assert_equal item, @ii.find_by_id(240)
    assert_nil @ii.find_by_id(2631215446511)
  end

  def test_find_all_by_item_id
    assert_equal 4, @ii.find_all_by_item_id(263519844).count
    assert_equal [], @ii.find_all_by_item_id(926459824508723047)
  end

  def test_find_all_by_invoice_id
    assert_equal 7, @ii.find_all_by_invoice_id(55).count
    assert_equal [], @ii.find_all_by_invoice_id(926459824508723047)
  end

  def test_new_highest_id
    assert_equal 21821, @ii.new_highest_id
  end

  def test_it_can_create_new_invoice_item
    expected = @ii.new_highest_id

    attributes = {
      :id => 21831,
      :item_id => 7,
      :invoice_id => 8,
      :quantity => 1,
      :unit_price => BigDecimal(10.99, 4),
      :created_at => Time.now,
      :updated_at => Time.now
    }

    @ii.create(attributes)

    assert_equal expected, attributes[:id]
  end

  def test_it_can_update_invoice_item
    attributes = {
      :id => 21820,
      :item_id => 7,
      :invoice_id => 8,
      :quantity => 2,
      :unit_price => "1099"
      }

    @ii.update(21820, attributes)

    item_test_updated_at = @ii.find_by_id(21820).updated_at.strftime("%d/%m/%Y")

    assert_equal BigDecimal("1099".to_i), @ii.find_by_id(21820).unit_price
    assert_equal 21820, @ii.find_by_id(21820).id
    assert_equal 2, @ii.find_by_id(21820).quantity
    assert_equal Time.now.strftime("%d/%m/%Y"), item_test_updated_at
  end

  def test_it_can_delete_invoice_item
    @ii.delete(1)

    assert_nil @ii.find_by_id(1)
  end

  def test_inspect
    assert_equal "#<InvoiceItemRepository 584 rows>", @ii.inspect
  end
end
