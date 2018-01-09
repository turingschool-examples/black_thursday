require_relative 'test_helper'
require_relative '../lib/invoice_repository'
class InvoiceRepositoryTest < Minitest::Test
  def setup
    parent = mock("SalesEngine")
    file_path = './test/fixtures/invoices_truncated.csv'
    @ir = InvoiceRepository.new(file_path, parent)
  end

  def test_all_returns_array_of_invoice_instances
    invoices = @ir.all

    value = invoices.all? do |invoice|
      invoice.class == Invoice
    end

    assert value
  end

  def test_find_by_id_returns_nil_if_no_matching_id
    assert_nil @ir.find_by_id(200)
  end

  def test_find_by_id_returns_invoice_instance_with_matching_id
    invoice = @ir.find_by_id(2)

    assert_equal 2, invoice.id
  end

  def test_find_all_by_customer_id_returns_all_invoice_instances_with_matching_id
    invoices = @ir.find_all_by_customer_id(5)

    value = invoices.all? do |invoice|
      invoice.customer_id == 5
    end

    assert value
  end

  def test_find_all_by_customer_id_returns_empty_array_if_no_matching_id
    assert_equal [], @ir.find_all_by_customer_id(500)
  end

  def test_find_all_by_merchant_id_returns_all_invoice_instances_with_matching_id
    invoices = @ir.find_all_by_merchant_id(12334753)

    value = invoices.all? do |invoice|
      invoice.merchant_id == 12334753
    end

    assert value
  end

  def test_find_all_by_merchant_id_returns_empty_array_if_no_matching_id
    assert_equal [], @ir.find_all_by_merchant_id(11111111)
  end

  def test_find_all_by_status_returns_all_invoice_instances_with_matching_status
    invoices = @ir.find_all_by_status("shipped")

    value = invoices.all? do |invoice|
      invoice.status == "shipped"
    end

    assert value
  end

  def test_find_all_by_status_returns_empty_array_if_no_matching_status
    assert_equal [], @ir.find_all_by_status("shiped")
  end

  def
    skip test_invoices_created_each_weekday_returns_hash_of_weekedays_with_number_of_invoices_created_on_weekday
    assert_equal Hash.new + {"Saturday"=>3, "Friday"=>5, "Sunday"=>1, "Monday"=>1, "Thursday"=>1, "Tuesday"=>1}, @ir.invoices_created_each_weekday
  end
end
