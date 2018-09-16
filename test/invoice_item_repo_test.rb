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






end
