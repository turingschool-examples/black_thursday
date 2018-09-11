require_relative '../test/test_helper'
require_relative '../lib/invoice_repository'

class InvoiceRepositoryTest < Minitest::Test

  def setup
    @ir = InvoiceRepository.new
    @hash = {
      :id          => "6",
      :customer_id => "7",
      :merchant_id => "8",
      :status      => "pending",
      :created_at  => "2016-01-11 09:34:06 UTC",
      :updated_at  => "2016-01-11 09:34:06 UTC"
    }
  end

  def test_it_exists
    assert_instance_of InvoiceRepository, @ir
  end

  def test_has_no_items_to_start
    @ir = InvoiceRepository.new
    assert_equal [], @ir.all
  end

  def test_it_can_add_by_hash_attributes_with_id
    @ir.create(@hash)
    hash2 = {
      :id          => "7",
      :customer_id => "21",
      :merchant_id => "9",
      :status      => "active",
      :created_at  => "2016-01-11 09:34:06 UTC",
      :updated_at  => "2016-01-11 09:34:06 UTC"
    }
    @ir.create(hash2)
    assert_equal 2, @ir.all.length
  end

  def test_it_can_add_by_hash_attributes_without_id
    @ir.create(@hash)
    hash2 = {
      :customer_id => "21",
      :merchant_id => "9",
      :status      => "active",
      :created_at  => "2016-01-11 09:34:06 UTC",
      :updated_at  => "2016-01-11 09:34:06 UTC"
    }
    @ir.create(hash2)
    assert_equal 2, @ir.all.length
  end

  def test_it_can_find_all_by_customer_id
    @ir.create(@hash)
    hash2 = {
      :customer_id => "21",
      :merchant_id => "9",
      :status      => "active",
      :created_at  => "2016-01-11 09:34:06 UTC",
      :updated_at  => "2016-01-11 09:34:06 UTC"
    }
    @ir.create(hash2)
    assert_equal 1, @ir.find_all_by_customer_id(21).length
  end

  def test_it_can_find_all_by_merchant_id
    @ir.create(@hash)
    hash2 = {
      :customer_id => "21",
      :merchant_id => "9",
      :status      => "active",
      :created_at  => "2016-01-11 09:34:06 UTC",
      :updated_at  => "2016-01-11 09:34:06 UTC"
    }
    @ir.create(hash2)
    assert_equal 1, @ir.find_all_by_merchant_id(9).length
  end

  def test_it_can_find_all_by_merchant_id
    @ir.create(@hash)
    hash2 = {
      :customer_id => "21",
      :merchant_id => "9",
      :status      => "active",
      :created_at  => "2016-01-11 09:34:06 UTC",
      :updated_at  => "2016-01-11 09:34:06 UTC"
    }
    @ir.create(hash2)
    assert_equal 1, @ir.find_all_by_status("active").length
  end


end
