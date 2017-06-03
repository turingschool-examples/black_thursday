require 'minitest'
require 'minitest/autorun'
require 'minitest/emoji'
require_relative '../lib/invoice_item_repository'
require 'pry'
class InvoiceItemRepositoryTest < Minitest::Test

  def test_new_instance
    iir = InvoiceItemRepository.new("./test/data/invoice_items_fixture.csv", self)

    assert_instance_of InvoiceItemRepository, iir
  end

  def test_return_all
    iir = InvoiceItemRepository.new("./test/data/invoice_items_fixture.csv", self)
    expected = [263519844, 263454779, 263454779,
                263553176, 263529264, 263557908,
                263452311, 263558834, 263537372 ]
    x = iir.all
    actual = x.map { |i| i.item_id }

    assert_equal expected, actual
  end

  def test_return_find_by_id_good_id
    iir = InvoiceItemRepository.new("./test/data/invoice_items_fixture.csv", self)
    expected = 263553176
    x = iir.find_by_id(13)
    actual = x.item_id

    assert_equal expected, actual
  end

  def test_return_find_by_id_bad_id
    iir = InvoiceItemRepository.new("./test/data/invoice_items_fixture.csv", self)

    assert_nil iir.find_by_id(55)
  end

  def test_return_find_all_by_id_good_id
    iir = InvoiceItemRepository.new("./test/data/invoice_items_fixture.csv", self)
    expected = [2, 190]
    x = iir.find_all_by_id(263454779)
    actual = x.map { |i| i.id }

     assert_equal expected, actual
  end

  def test_return_find_all_by_id_bad_id
    iir = InvoiceItemRepository.new("./test/data/invoice_items_fixture.csv", self)

    assert_equal [], iir.find_all_by_id(445)
  end
end
