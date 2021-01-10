require 'minitest/autorun'
require 'minitest/pride'
require './lib/invoice_item_repo'

class InvoiceItemRepo < Minitest::Test
  def setup
    @ii_repo = InvoiceItemRepository.new('./test/dummy_data/invoice_item_dummies.csv')
  end

  def test_it_exists_with_attributes
    assert_instance_of InvoiceItemRepository, @ii_repo
  end

  def test_it_returns_all_iis
    assert_equal 17, @ii_repo.all.length
    assert_equal Array, @ii_repo.all.class
  end

  def test_it_finds_by_id
    ii = @ii_repo.find_by_id(2352)
    assert_equal 2352, ii.id
    assert_equal 524, ii.invoice_id
    assert_equal 263543976, ii.item_id
    assert_equal nil, @ii_repo.find_by_id(22)
  end

  def test_it_finds_all_by_item_id
    ii = @ii_repo.find_all_by_item_id(263444527)
    assert_equal 1, ii.length
    assert_equal 2343, ii[0].id
    assert_equal 520, ii[0].invoice_id
    assert_equal [], @ii_repo.find_all_by_item_id(22)
  end

  def test_it_finds_all_by_invoice_id
    assert_equal 4, @ii_repo.find_all_by_invoice_id(519).length
    assert_equal [], @ii_repo.find_all_by_invoice_id(22)
  end

  def test_it_returns_max_id
    assert_equal 2353, @ii_repo.max_id
  end

  def test_it_can_create_a_new_item
    ii_attr = {
      :item_id => 7,
      :invoice_id => 8,
      :quantity => 1,
      :unit_price => BigDecimal(10.99, 4),
      :created_at => 10,
      :updated_at => 12
    }
    assert_equal 2353, @ii_repo.max_id
    @ii_repo.create(ii_attr)
    ii = @ii_repo.find_by_id(2354)
    assert_equal 2354, @ii_repo.max_id
    assert_equal 8, ii.invoice_id
    assert_equal 10.99, ii.unit_price
  end
end
