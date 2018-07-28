require './test/test_helper'
require './lib/invoice_repository'
require './lib/invoice'
require './lib/file_loader'

class InvoiceRepositoryTest < Minitest::Test
  include FileLoader

  def setup
    @mock_data = [
      {:id         => 1,
      :customer_id => 7,
      :merchant_id => 8,
      :status      => "pending",
      :created_at  => Time.now,
      :updated_at  => Time.now},
      {:id         => 2,
      :customer_id => 7,
      :merchant_id => 10,
      :status      => "shipped",
      :created_at  => Time.now,
      :updated_at  => Time.now},
      {:id         => 3,
      :customer_id => 11,
      :merchant_id => 12,
      :status      => "returned",
      :created_at  => Time.now,
      :updated_at  => Time.now},
      {:id         => 4,
      :customer_id => 13,
      :merchant_id => 12,
      :status      => "pending",
      :created_at  => Time.now,
      :updated_at  => Time.now}]

    @invoice_repo = InvoiceRepository.new(@mock_data)
  end

  def test_it_exists
    assert_instance_of InvoiceRepository, @invoice_repo
  end

  def test_it_can_find_all_invoices
    assert_equal 4, @invoice_repo.all.count
  end

  def test_it_can_find_all_invoices_by_id_number
    assert_equal @invoice_repo.all[0], @invoice_repo.find_by_id(1)
    assert_equal @invoice_repo.all[3], @invoice_repo.find_by_id(4)
  end

  def test_it_can_find_all_invoices_by_customer_id
    result = [@invoice_repo.all[0], @invoice_repo.all[1]]
    assert_equal result, @invoice_repo.find_all_by_customer_id(7)
  end

  def test_it_can_find_all_invoices_by_merchant_id
    result = [@invoice_repo.all[2], @invoice_repo.all[3]]
    assert_equal result, @invoice_repo.find_all_by_merchant_id(12)
  end

  def test_it_can_find_all_by_status
    result = [@invoice_repo.all[0], @invoice_repo.all[3]]
    assert_equal result, @invoice_repo.find_all_by_status(:pending)
  end

  def test_it_can_create_a_new_invoice
    @invoice_repo.create({
    :customer_id => 13,
    :merchant_id => 12,
    :status      => "pending",
    :created_at  => Time.now,
    :updated_at  => Time.now})

    assert_equal 5, @invoice_repo.all[-1].id
    assert_equal 13, @invoice_repo.all[-1].customer_id
  end

  def test_it_can_update_an_invoice
    @invoice_repo.update(1, {:status => "shipped"})

    assert_equal "shipped", @invoice_repo.all[0].status
  end

  def test_it_can_delete_an_invoice
    @invoice_repo.delete(4)

    assert_equal 3, @invoice_repo.all.count
    assert_equal 3, @invoice_repo.all[-1].id
  end

end
