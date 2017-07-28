require 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/invoice_item_repository'


class InvoiceItemRepositoryTest < Minitest::Test
  def test_it_can_be_created
    ii = InvoiceItemRepository.new(1)
  end

  def test_it_can_be_added_to
    hash   = {id: 122, item_id: 7, invoice_id: 1}
    ii = InvoiceItemRepository.new(1)
    ii.add_data(hash)
    assert_equal  1, ii.all.count
  end

  def setup
    @ii_repo = InvoiceItemRepository.new(self)
    hash_one   = {id: 122, item_id: 7, invoice_id: 1}
    hash_two   = {id: 123, item_id: 2, invoice_id: 2}
    hash_three = {id: 124, item_id: 5, invoice_id: 1}
    hash_four  = {id: 125, item_id: 5, invoice_id: 3}

    @ii_repo.add_data(hash_one)
    @ii_repo.add_data(hash_two)
    @ii_repo.add_data(hash_three)
    @ii_repo.add_data(hash_four)
  end

  def test_all_is_working
    ii_repo = InvoiceItemRepository.new(self)

    assert_equal 0, ii_repo.all.count

    assert_equal 4, @ii_repo.all.count
  end

  def test_find_by_id_is_returning_nil_for_blank_items
    assert_nil @ii_repo.find_by_id(1527)
  end

  def test_find_by_id_is_working_for_entire
    save = @ii_repo.find_by_id(125)
    assert_instance_of InvoiceItem, save
    assert_equal 5, save.item_id
    assert_equal 3, save.invoice_id
  end

  def test_find_all_by_item_id_returns_blank_if_not_found
    ii_repo = InvoiceItemRepository.new(self)
    assert ii_repo.find_all_by_item_id(123).empty?
    assert @ii_repo.find_all_by_item_id(1234).empty?
  end

  def test_find_all_by_item_id_works_for_one_entry
    one = @ii_repo.find_all_by_item_id(7)
    two = @ii_repo.find_all_by_item_id(2)

    assert_equal 1  , one.count
    assert_equal 122, one.first.id
    assert_equal 1  , two.count
    assert_equal 123, two.first.id
  end

  def test_find_all_by_item_id_works_for_multiple_entries
    one = @ii_repo.find_all_by_item_id(5)
    assert_equal 2, one.count
    assert_equal 124, one.first.id
    assert_equal 125, one.last.id
  end

  def test_find_all_by_invoice_id_returns_blank_if_not_found
    ii_repo = InvoiceItemRepository.new(self)
    assert ii_repo.find_all_by_invoice_id(4).empty?
    assert @ii_repo.find_all_by_invoice_id(4).empty?
  end

  def test_find_all_by_invoice_id_works_for_one_entry
    one = @ii_repo.find_all_by_invoice_id(2)
    two = @ii_repo.find_all_by_invoice_id(3)

    assert_equal 1  , one.count
    assert_equal 123, one.first.id
    assert_equal 1  , two.count
    assert_equal 125, two.first.id
  end

  def test_find_all_by_invoice_id_works_for_multiple_entries
    one = @ii_repo.find_all_by_invoice_id(1)

    assert_equal 2  , one.count
    assert_equal 122, one.first.id
    assert_equal 124, one.last.id
  end

end
