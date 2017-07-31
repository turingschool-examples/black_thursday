require 'minitest'
require 'minitest/autorun'
require 'minitest/emoji'
require './lib/invoice_item_repository'
require 'bigdecimal'
require 'pry'


class InvoiceItemRepositoryTest < Minitest::Test
  def test_it_can_be_created
    repo = InvoiceItemRepository.new(self)
    assert_instance_of InvoiceItemRepository, repo
  end

  def test_it_has_invoice_items
    repo = InvoiceItemRepository.new(self)
    assert_equal [], repo.invoice_items
  end

  def test_it_can_load_invoice_items
    repo = InvoiceItemRepository.new(self)
    repo.from_csv("./data/invoice_items_short.csv")
    assert_equal 10, repo.invoice_items.count
  end

  def test_all
    repo = InvoiceItemRepository.new(self)
    repo.from_csv("./data/invoice_items_short.csv")
    assert_equal 10, repo.all.count
  end

  def test_find_by_id
    repo = InvoiceItemRepository.new(self)
    repo.from_csv("./data/invoice_items_short.csv")
    assert_equal 3, repo.find_by_id(5).invoice_id
  end

  def test_it_find_all_by_invoice_id(invoice_id)
    repo = InvoiceItemRepository.new(self)
    repo.from_csv("./data/invoice_items_short.csv")
    binding.pry
    assert_instance_of 123400001, repo.find_all_by_invoice_id("5")[0].invoice_id
  end


  def invoice_item1
    {
      :id => 1,
      :item_id => 11,
      :invoice_id => 111,
      :quantity => 1,
      :unit_price => BigDecimal.new([1000],4) / 100,
      :created_at => "2012-02-26 20:56:41 UTC",
      :updated_at => "2012-02-26 20:56:51 UTC"
    }
  end

  def invoice_item2
    {
      :id => 2,
      :item_id => 22,
      :invoice_id => 222,
      :quantity => 2,
      :unit_price => BigDecimal.new([2000],4) / 100,
      :created_at => "2012-02-26 20:56:41 UTC",
      :updated_at => "2012-02-26 20:56:51 UTC"
    }
  end

  def invoice_item3
    {
      :id => 3,
      :item_id => 33,
      :invoice_id => 333,
      :quantity => 3,
      :unit_price => BigDecimal.new([3000],4) / 100,
      :created_at => "2012-02-26 20:56:41 UTC",
      :updated_at => "2012-02-26 20:56:51 UTC"
    }
  end

end
