require './test/test_helper.rb'

class InvoiceItemRepositoryTest < Minitest::Test
  attr_reader :repo

  def setup
    invoice_item_csv =  './test/fixtures/invoice_items.csv'
    parent = SalesEngine.new
    @repo = InvoiceItemRepository.new(invoice_item_csv, parent)
  end

  def test_it_exists
    assert_instance_of InvoiceItemRepository, repo
  end

  def test_all_array
    assert_equal 21830, repo.all.length
  end

  def test_find_by_id
    assert_equal InvoiceItem, repo.find_by_id(4).class
    assert_nil repo.find_by_id(0)
  end

  def test_finds_all_item_id
    assert_equal 18, repo.find_all_by_item_id(263454779).length
    assert_equal [], repo.find_all_by_item_id(0)
  end

  def test_finds_all_invoice_id
    assert_equal 8, repo.find_all_by_invoice_id(3).length
    assert_equal [], repo.find_all_by_invoice_id(0)
  end

end
