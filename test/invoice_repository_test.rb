require 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/invoice_repository'

class InvoiceRepositoryTest < Minitest::Test

  def setup
    @invoice_r = InvoiceRepository.new(self)
    hash_one   = {id: 123, merchant_id: 7, customer_id: 1,
                  status: "shipped"                       }
    hash_two   = {id: 123, merchant_id: 2, customer_id: 2,
                  status: "pending"                       }
    hash_three = {id: 124, merchant_id: 5, customer_id: 1,
                  status: "shipped"                       }
    hash_four  = {id: 125, merchant_id: 5, customer_id: 3,
                  status: "shipped"                       }
    @invoice_r.add_data(hash_one)
    @invoice_r.add_data(hash_two)
    @invoice_r.add_data(hash_three)
    @invoice_r.add_data(hash_four)
  end

  def test_it_exists
    i = InvoiceRepository.new(1)
    assert i
    assert_instance_of InvoiceRepository, i
  end

  def test_it_can_be_added_to
    ir = InvoiceRepository.new(1)
    hash_one = {status: "shipped",
                id: 1, merchant_id: 3}
    hash_two = {status: "pending",
                id: 2, merchant_id: 4}

    ir.add_data(hash_one)
    ir.add_data(hash_two)

    assert_equal 1        , ir.invoices.first.id
    assert_equal "shipped", ir.invoices.first.status
    assert_equal 3        , ir.invoices.first.merchant_id
    assert_equal 4        , ir.invoices.last.merchant_id
    assert_equal "pending", ir.invoices.last.status
    assert_equal 2        , ir.invoices.last.id
  end

  def test_all_is_working
    assert_equal 4        , @invoice_r.all.count
    assert_equal 123      , @invoice_r.all.first.id
    assert_equal "shipped", @invoice_r.all.first.status
    assert_equal "pending", @invoice_r.all[1].status
    assert_equal 125      , @invoice_r.all.last.id
  end

  def test_find_by_id_returning_nil_for_non_existing_ids
    assert_nil @invoice_r.find_by_id(14331)
    assert_nil @invoice_r.find_by_id(54322)
  end

  def test_find_by_id_working
    save_one = @invoice_r.find_by_id(123)
    save_two = @invoice_r.find_by_id(125)

    assert_equal @invoice_r.invoices[1], save_one
    assert_equal @invoice_r.invoices.last, save_two
  end

  def test_find_all_by_customer_id_returns_blank_if_none_match
    assert_equal [], @invoice_r.find_all_by_customer_id(120)
    assert_equal [], @invoice_r.find_all_by_customer_id(12032)
  end

  def test_find_all_by_customer_id_works_for_one_entry
    list_one = @invoice_r.find_all_by_customer_id(3)
    list_two = @invoice_r.find_all_by_customer_id(2)

    assert_equal 1        , list_one.count
    assert_equal "shipped", list_one.first.status
    assert_equal 125      , list_one.first.id

    assert_equal 1        , list_two.count
    assert_equal "pending", list_two.first.status
    assert_equal 123      , list_two.first.id
  end

  def test_find_all_by_customer_id_works_for_multiple_entries
    list = @invoice_r.find_all_by_customer_id(1)

    assert_equal 2        , list.count
    assert_equal "shipped", list.first.status
    assert_equal 7        , list.first.merchant_id
    assert_equal "shipped", list.last.status
    assert_equal 5        , list.last.merchant_id
  end

  def test_find_all_by_merchant_id_returns_blank_if_none_match
    assert_equal [], @invoice_r.find_all_by_merchant_id(120)
    assert_equal [], @invoice_r.find_all_by_merchant_id(12032)
  end

  def test_find_all_by_merchant_id_works_for_one_entry
    list_one = @invoice_r.find_all_by_merchant_id(7)
    list_two = @invoice_r.find_all_by_merchant_id(2)

    assert_equal 1        , list_one.count
    assert_equal "shipped", list_one.first.status
    assert_equal 123      , list_one.first.id

    assert_equal 1        , list_two.count
    assert_equal "pending", list_two.first.status
    assert_equal 123      , list_two.first.id
  end

  def test_find_all_by_merchant_id_works_for_multiple_entries
    list = @invoice_r.find_all_by_merchant_id(5)

    assert_equal 2        , list.count
    assert_equal "shipped", list.first.status
    assert_equal 1        , list.first.customer_id
    assert_equal "shipped", list.last.status
    assert_equal 3        , list.last.customer_id
  end




  def test_find_all_by_status_returns_blank_if_none_match
    assert_equal [], @invoice_r.find_all_by_status("awesome")
    assert_equal [], @invoice_r.find_all_by_status("awesome")
  end

  def test_find_all_by_status_works_for_one_entry
    list_one = @invoice_r.find_all_by_status("pending")

    assert_equal 1        , list_one.count
    assert_equal "pending", list_one.first.status
    assert_equal 123      , list_one.first.id
  end

  def test_find_all_by_merchant_id_works_for_multiple_entries
    list = @invoice_r.find_all_by_status("shipped")

    assert_equal 3        , list.count
    assert_equal "shipped", list.first.status
    assert_equal 1        , list.first.customer_id
    assert_equal "shipped", list.last.status
    assert_equal 3        , list.last.customer_id
  end


end
