require './test/test_helper'
require './lib/invoice_item_repository'
require './lib/file_loader'
require 'bigdecimal'

class InvoiceItemRepositoryTest < Minitest::Test
  include FileLoader

  def setup
    @mock_data = [
      {:id        => 6,
      :item_id    => 7,
      :invoice_id => 8,
      :quantity   => 1,
      :unit_price => BigDecimal.new(5.99, 3),
      :created_at => Time.now,
      :updated_at => Time.now},
      {:id        => 7,
      :item_id    => 7,
      :invoice_id => 9,
      :quantity   => 1,
      :unit_price => BigDecimal.new(7.99, 3),
      :created_at => Time.now,
      :updated_at => Time.now},
      {:id        => 8,
      :item_id    => 8,
      :invoice_id => 9,
      :quantity   => 1,
      :unit_price => BigDecimal.new(10.99, 4),
      :created_at => Time.now,
      :updated_at => Time.now},
      {:id        => 9,
      :item_id    => 9,
      :invoice_id => 8,
      :quantity   => 1,
      :unit_price => BigDecimal.new(12.99, 4),
      :created_at => Time.now,
      :updated_at => Time.now}
      ]

    @invoice_item_repo = InvoiceItemRepository.new(@mock_data)
  end

  def test_it_exists
    assert_instance_of InvoiceItemRepository, @invoice_item_repo
  end

  def test_it_can_find_all_invoice_items
    assert_equal 4, @invoice_item_repo.all.count
  end

  def test_it_can_find_an_invoice_item_by_id
    assert_equal @invoice_item_repo.all[-1], @invoice_item_repo.find_by_id(9)
  end

  def test_it_can_find_invoice_items_by_invoice_item_id
    result = [@invoice_item_repo.all[0], @invoice_item_repo.all[1]]
    assert_equal result, @invoice_item_repo.find_all_by_item_id(7)
  end

  def test_it_can_find_invoice_items_by_invoice_id
    result = [@invoice_item_repo.all[1], @invoice_item_repo.all[2]]
    assert_equal result, @invoice_item_repo.find_all_by_invoice_id(9)
  end

  def test_it_can_create_a_new_invoice_item
    @invoice_item_repo.create({
    :item_id    => 9,
    :invoice_id => 10,
    :quantity   => 5,
    :unit_price => BigDecimal.new(12.99, 4),
    :created_at => Time.now,
    :updated_at => Time.now})

    assert_equal 10, @invoice_item_repo.all[-1].id
    assert_equal 10, @invoice_item_repo.all[-1].invoice_id
    assert_equal 5, @invoice_item_repo.all[-1].quantity
  end

  def test_it_can_update_all_invoice_attributes
    @invoice_item_repo.update(6, {:quantity => 10, :unit_price => BigDecimal(3.99, 3)})

    assert_equal 10, @invoice_item_repo.all[0].quantity
    assert_equal 3.99, @invoice_item_repo.all[0].unit_price
  end

  def test_it_can_update_one_invoice_item_attribute
    @invoice_item_repo.update(6, {:unit_price => BigDecimal(13.99, 4)})

    assert_equal 13.99, @invoice_item_repo.all[0].unit_price
  end

  def test_it_can_delete_an_invoice_item
    @invoice_item_repo.delete(9)

    assert_equal 3, @invoice_item_repo.all.count
    assert_equal 8, @invoice_item_repo.all[-1].id
  end
end
