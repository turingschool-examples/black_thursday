require './lib/invoice_repository'
require './lib/invoice'
require 'minitest/autorun'
require 'minitest/pride'

class InvoiceRepositoryTest < Minitest::Test
  def setup
    @now = Time.now
    @ir = InvoiceRepository.new

    @invoice_1 = {
      :id          => 1,
      :customer_id => 3,
      :merchant_id => 8,
      :status      => "pending",
      :created_at  => @now,
      :updated_at  => @now,
    }

    @invoice_2 = {
      :id          => 2,
      :customer_id => 6,
      :merchant_id => 8,
      :status      => "pending",
      :created_at  => @now,
      :updated_at  => @now,
    }

    @invoice_3 = {
      :id          => 3,
      :customer_id => 7,
      :merchant_id => 8,
      :status      => "shipped",
      :created_at  => @now,
      :updated_at  => @now,
    }

    @invoice_4 = {
      :id          => 4,
      :customer_id => 7,
      :merchant_id => 8,
      :status      => "shipped",
      :created_at  => @now,
      :updated_at  => @now,
    }
  end

  def create_invoices
    @ir.create(@invoice_1)
    @ir.create(@invoice_2)
    @ir.create(@invoice_3)
    @ir.create(@invoice_4)
  end

  def test_it_exists
    assert_instance_of InvoiceRepository, @ir
  end

  def test_it_creates_invoice_instances
    assert_empty @ir.instances

    create_invoices

    expected = [Invoice.new(@invoice_1), Invoice.new(@invoice_2), Invoice.new(@invoice_3), Invoice.new(@invoice_4)]
    result = @ir.instances

    result.each_with_index {|invoice, index| assert_equal invoice, expected[index]}
    assert_equal 4, @ir.instances.count
  end

  def test_find_all_by_customer_id_returns_empty_array_if_none_found
    create_invoices

    assert_equal [], @ir.find_all_by_customer_id(9)
  end

  def test_find_all_by_customer_id_returns_matches
    create_invoices

    expected = [Invoice.new(@invoice_3), Invoice.new(@invoice_4)]
    result = @ir.find_all_by_customer_id(9)

    result.each_with_index {|invoice, index| assert_equal invoice, expected[index]}
  end

  def test_find_all_by_status_returns_empty_array_if_no_matches
    create_invoices

    assert_equal [], @ir.find_all_by_status(:returned)
  end

  def test_find_all_by_status_returns_matches
    create_invoices

    expected = [Invoice.new(@invoice_3), Invoice.new(@invoice_4)]
    result = @ir.find_all_by_status(:shipped)

    result.each_with_index {|invoice, index| assert_equal invoice, expected[index]}
  end
end
