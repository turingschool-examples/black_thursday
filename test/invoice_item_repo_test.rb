require_relative 'test_helper'
require_relative '../lib/invoice_item_repo'

class InvoiceItemRepoTest < Minitest::Test
  attr_reader :ir

  def setup
    @ir = InvoiceItemRepo.new("./data/invoice_item_fixtures.csv")
  end

  def test_it_exists
    assert_instance_of InvoiceItemRepo, ir
  end

  def test_it_can_return_all_invoice_items
    assert_equal 101, ir.all.count
  end

  def test_it_can_find_by_id
    assert_equal 263451719, ir.find_by_id(3).item_id
  end

  def test_it_can_find_by_item_id
    assert_equal 1, ir.find_by_item_id(263451719).count
  end

  # def test_it_can_find_all
  #
  # end
end
