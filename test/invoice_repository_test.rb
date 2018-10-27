require_relative './test_helper'


class InvoiceRepositoryTest < Minitest::Test

  def setup
    @ir = InvoiceRepository.new('./test/data/invoice_test_data.csv')
  end

  def test_it_exists
    assert_instance_of InvoiceRepository, @ir
  end

  def test_it_can_create_repository_array
    #this test ignores the setup array
    assert_instance_of Array, @ir.create_repo_array('./test/data/invoice_test_data.csv')
  end

  def test_invoice_repo_has_repository_array_and_returns_all
    assert_equal 25, @ir.all.count
    assert_instance_of Array, @ir.all
  end

  def test_find_by_id
    item = @ir.repo_array[12]
    assert_equal item, @ir.find_by_id(13)
  end

  def test_find_all_by_customer_id
    assert_equal 4, @ir.find_all_by_customer_id(2).count
  end

  def test_it_can_find_all_by_merchant_id
    assert_instance_of Invoice, @ir.find_all_by_merchant_id(12336652).first
    assert_equal 2, @ir.find_all_by_merchant_id(12336652).count
  end

  def test_it_can_find_all_by_status
    assert_equal 10, @ir.find_all_by_status('pending').count
    assert_equal 1, @ir.find_all_by_status('returned').count
  end

  def test_it_can_find_max_id_and_increase_it_by_one
    assert_equal 26, @ir.new_highest_id
  end

  def test_we_can_create_new_invoice_and_increment_its_id_up_one
    new_invoice = @ir.create({
        :customer_id => 7,
        :merchant_id => 8,
        :status      => "pending",
        })
    assert_instance_of Invoice, new_invoice
    assert_equal 26, new_invoice.id
    assert_equal 'pending', new_invoice.status
    assert_equal 26, @ir.all.count
  end

  def test_we_can_update_attributes
    original_updated_at = @ir.find_by_id(10).updated_at
    @ir.update(10, {:status => 'shipped'})
    updated_invoice = @ir.find_by_id(10)
    assert_equal 'shipped', updated_invoice.status
    assert updated_invoice.updated_at > original_updated_at
  end

  def test_it_can_delete_by_id
    @ir.delete(13)
    assert_equal nil, @ir.find_by_id(13)
  end

end
