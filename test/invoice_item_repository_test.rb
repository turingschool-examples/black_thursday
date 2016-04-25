require_relative 'test_helper'
require_relative '../lib/invoice_item_repository'

class InvoiceItemRepositoryTest < Minitest::Test
  attr_reader :ii1, :ii2, :repository

  def setup
    @ii1 = InvoiceItem.new({
    :id          => 6,
    :item_id     => 7,
    :invoice_id  => 8,
    :quantity    => 1,
    :unit_price  => BigDecimal.new(1200, 4),
    :created_at  => Time.new.to_s,
    :updated_at  => Time.new.to_s
    })

    @ii2 = InvoiceItem.new({
    :id          => 9,
    :item_id     => 38,
    :invoice_id  => 93,
    :quantity    => 4,
    :unit_price  => BigDecimal.new(1099, 4),
    :created_at  => Time.new.to_s,
    :updated_at  => Time.new.to_s
    })

    @repository = InvoiceItemRepository.new
    @repository.invoice_item_repository = ([ii1, ii2])
  end

  def test_it_creates_a_new_instance_of_invoice_item_repo
    assert_equal InvoiceItemRepository, repository.class
  end

  def test_it_returns_an_array_of_all_invoice_instances
    assert_equal 2, repository.all.length
  end

  def test_it_can_return_an_invoice_by_invoice_id
    invoice_item = repository.find_by_id(9)
    assert_equal 4,invoice_item.quantity
  end

  def test_it_will_return_nil_if_invoice_item_does_not_exist
    assert_equal nil, repository.find_by_id(124)
  end

  def test_it_can_return_an_array_of_invoices_by_item_id
    invoice_item = repository.find_all_by_item_id(38)
    assert_equal 4,invoice_item[0].quantity
  end

  def test_it_will_return_an_empty_array_if_item_id_doesnt_exist
    assert_equal [], repository.find_all_by_item_id(124)
  end

  def test_it_can_return_an_array_of_invoices_by_invoice_id
    invoice_item = repository.find_all_by_invoice_id(93)
    assert_equal 4,invoice_item[0].quantity
  end

  def test_it_will_return_an_empty_array_if_invoice_id_doesnt_exist
    assert_equal [], repository.find_all_by_invoice_id(124)
  end

end
