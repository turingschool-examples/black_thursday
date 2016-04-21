require_relative 'test_helper'
require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/sales_engine.rb'
require_relative '../lib/csv_parser.rb'
require_relative'../lib/merchant_repository.rb'


class SalesEngineTest < MiniTest::Test
   attr_reader :se

  def setup
    @se = SalesEngine.from_csv({
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv",
      :invoices  => "./data/invoices.csv"
    })
  end

  def test_it_creates_instance
    assert se
  end

  def test_it_creates_item_repository_instance
    assert se.items
  end

  def test_it_creates_merchant_repository_instance
    assert se.merchants
  end

  def test_it_finds_in_merchant_repository
    mr = se.merchants
    assert_equal "CJsDecor", mr.find_by_name("CJsDecor").name
  end

  def test_it_finds_in_item_repository
    ir = se.items
    assert_equal "510+ RealPush Icon Set", ir.find_by_name("510+ RealPush Icon Set").name
  end

  def test_it_links_merchants_and_items
    merchant = se.merchants.find_by_id(12334105)
    assert_equal 3, merchant.items.count
  end

  def test_it_links_merchants_to_items
    refute se.items.all.first.merchant.nil?
  end

  def test_it_creates_invoices_repository
    assert se.invoices
  end

end
