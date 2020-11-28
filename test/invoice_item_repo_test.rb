require 'simplecov'
SimpleCov.start
require 'bigdecimal'
require 'time'
require 'minitest/autorun'
require 'minitest/pride'
require 'pry'
require_relative '../lib/invoice_item_repo'

class InvoiceItemRepoTest < Minitest::Test
  def test_it_exists
    iir = InvoiceItemRepo.new("./test/fixtures/invoice_items.csv")
    assert_instance_of InvoiceItemRepo, iir
  end

  def test_it_returns_all_in_array
    iir = InvoiceItemRepo.new("./test/fixtures/invoice_items.csv")

    assert_equal 13, iir.all.count
    assert_instance_of InvoiceItem, iir.all.first
  end

  def test_it_can_find_by_id
    iir = InvoiceItemRepo.new("./test/fixtures/invoice_items.csv")

    expected = iir.all.first
    assert_equal expected, iir.find_by_id(1)

    expected = iir.all.last
    assert_equal expected, iir.find_by_id(13)
    assert_nil iir.find_by_id(166)
  end

  def test_it_can_find_all_by_item_id
    iir = InvoiceItemRepo.new("./test/fixtures/invoice_items.csv")

    it_one = iir.find_by_id(12)
    it_two = iir.find_by_id(13)

    expected = [it_one, it_two]

    assert_equal expected, iir.find_all_by_item_id(263438971)
    assert_equal [], iir.find_all_by_item_id(123413413241343)
  end

  def test_it_can_find_all_by_invoice_id
    iir = InvoiceItemRepo.new("./test/fixtures/invoice_items.csv")

    it_one = iir.find_by_id(12)
    it_two = iir.find_by_id(13)

    expected = [it_one, it_two]

    assert_equal expected, iir.find_all_by_invoice_id(3)
    assert_equal [], iir.find_all_by_invoice_id(123413413241343)
  end

  def test_it_can_create_invoice_item_with_next_id_value
    iir = InvoiceItemRepo.new("./test/fixtures/invoice_items.csv")

    actual  = iir.create({
      :id          => 41,
      :item_id        => 8,
      :invoice_id => 4,
      :quantity => 7,
      :unit_price  => BigDecimal(10.99,4),
      :created_at  => Time.now,
      :updated_at  => Time.now,
                        })

    assert_instance_of InvoiceItem, actual
    assert_equal actual, iir.all.last
  end

  def test_it_can_update_invoice_item
    iir = InvoiceItemRepo.new("./test/fixtures/invoice_items.csv")

    actual = iir.find_by_id(13)
    iir.update(13,{
      :id          => 12,
      :quantity => 7,
      :unit_price  => BigDecimal(50.50,4),
      :updated_at  => Time.now,
                        })

    assert_equal 13, iir.all.last.id
    assert_equal 7, actual.quantity
    assert_instance_of InvoiceItem, actual
    assert_equal 50.50, actual.unit_price
  end

  def test_it_can_delete_by_id
    iir = InvoiceItemRepo.new("./test/fixtures/invoice_items.csv")

    iir.delete(3)
    assert_nil iir.find_by_id(3)
  end
end
