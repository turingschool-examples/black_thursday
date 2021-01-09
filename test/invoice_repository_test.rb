require_relative './test_helper'
require 'time'
require './lib/invoice'
require './lib/invoice_repository'
require 'csv'

class InvoiceRepositoryTest < Minitest::Test
  
  def setup
    @ir = InvoiceRepository.new("./fixture_data/invoices.csv", "engine")
  end

  def test_it_exists_and_has_attributes
    assert_instance_of InvoiceRepository, @ir
    assert_equal 4985, @ir.all.count
  end

  def test_it_finds_by_id
    invoice = @ir.all.first

    assert_equal invoice, @ir.find_by_id(1)
    assert_nil @ir.find_by_id(2631215446511)
  end

  def test_find_all_by_customer_id
    
    assert_equal 9, @ir.find_all_by_customer_id(11).count
    assert_equal [], @ir.find_all_by_customer_id(1113413133)
  end

  def test_find_all_by_merchant_id
    
    assert_equal 11, @ir.find_all_by_merchant_id(12334365).count
    assert_equal [], @ir.find_all_by_merchant_id(1113413133)
  end

  def test_find_all_by_status
    
    assert_equal 2839, @ir.find_all_by_status(:shipped).count
    assert_equal [], @ir.find_all_by_status("not a real status suckas")
  end

  def test_new_highest_id
    assert_equal 4986, @ir.new_highest_id
  end

  def test_it_can_create_new_item
    expected = @ir.new_highest_id
    attributes = ({
      :id          => 6,
      :customer_id => 7,
      :merchant_id => 8,
      :status      => "pending",
      :created_at  => Time.now,
      :updated_at  => Time.now,
    })

    @ir.create(attributes)

    assert_equal expected, attributes[:id]
  end

  def test_it_can_update_invoice_1
    assert_equal :pending, @ir.find_by_id(55).status

    @ir.update(55, {status: :shipped, id: 425222666262})
    invoice_test_updated_at = @ir.find_by_id(55).updated_at.strftime("%d/%m/%Y")

    assert_equal 55, @ir.find_by_id(55).id
    assert_equal :shipped, @ir.find_by_id(55).status
    assert_equal Time.now.strftime("%d/%m/%Y"), invoice_test_updated_at
  end

  def test_it_can_update_invoice_2
    @ir.update(55, {status: "pending", id: 425222666262})
    invoice_test_updated_at = @ir.find_by_id(55).updated_at.strftime("%d/%m/%Y")

    assert_equal 55, @ir.find_by_id(55).id
    assert_equal :pending, @ir.find_by_id(55).status
    assert_equal "14/10/2008", invoice_test_updated_at
  end

  
  def test_it_can_delete_item
    expect = @ir.find_by_id(55)

    assert_equal expect, @ir.find_by_id(55)
    @ir.delete(55)

    assert_nil @ir.find_by_id(55)
  end

end