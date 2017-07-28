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

  def te


end
