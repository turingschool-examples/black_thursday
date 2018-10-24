require './lib/invoice_repository'
require './lib/invoice'
require 'minitest/autorun'
require 'minitest/pride'

class InvoiceRepositoryTest < Minitest::Test
  def setup
    @now = Time.now
    @ir = InvoiceRepository.new

    @item_1 = {
      :id          => 1,
      :customer_id => 7,
      :merchant_id => 8,
      :status      => "pending",
      :created_at  => @now,
      :updated_at  => @now,
    }

    @item_2 = {
      :id          => 2,
      :customer_id => 7,
      :merchant_id => 8,
      :status      => "pending",
      :created_at  => @now,
      :updated_at  => @now,
    }

    @item_3 = {
      :id          => 3,
      :customer_id => 7,
      :merchant_id => 8,
      :status      => "returned",
      :created_at  => @now,
      :updated_at  => @now,
    }

    @item_4 = {
      :id          => 4,
      :customer_id => 7,
      :merchant_id => 8,
      :status      => "shipped",
      :created_at  => @now,
      :updated_at  => @now,
    }
  end

  def create_invoices
    @ir.create(@item_1)
    @ir.create(@item_2)
    @ir.create(@item_3)
    @ir.create(@item_4)
  end

  def test_it_exists
    assert_instance_of InvoiceRepository, @ir
  end

  def test_it_creates_invoice_instances
    assert_empty @ir.instances

    create_items

    expected = [Invoice.new(@item_1), Invoice.new(@item_2), Invoice.new(@item_3), Invoice.new(@item_4)]
    result = @ir.instances

    result.each_with_index {|invoice, index| assert_equal invoice, expected[index]}
    assert_equal 4, @ir.instances.count
  end
end
