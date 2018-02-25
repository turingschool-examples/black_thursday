require_relative 'test_helper'
require_relative '../lib/invoice_repository'

class InvoiceRepositoryTest < Minitest::Test

  def setup
    @invoice_repo = InvoiceRepository.new('./test/fixtures/invoices_sample.csv')
  end

  def test_if_it_exists
    assert_instance_of InvoiceRepository, @invoice_repo
  end

  def test_inspect_method
    assert_instance_of String, @invoice_repo.inspect
  end

  def test_if_item_repository_has_items
    assert_instance_of Array, @invoice_repo.all
    assert_equal 20, @invoice_repo.all.count
    assert @invoice_repo.all.all? { |invoice| invoice.is_a?(Invoice)}
  end

  def test_if_it_can_load_correct_ids
    assert_equal 3, @invoice_repo.all.first.id
    assert_equal 1053, @invoice_repo.all[4].id
  end

  def test_if_it_can_load_correct_customer_id
    assert_equal 1, @invoice_repo.all.first.customer_id
    assert_equal 206, @invoice_repo.all[4].customer_id
    assert_equal 963, @invoice_repo.all.last.customer_id
  end

  def test_if_it_can_load_correct_status
    assert_equal :shipped, @invoice_repo.all.first.status
    assert_equal :shipped, @invoice_repo.all[4].status
    assert_equal :returned, @invoice_repo.all.last.status
  end

  def test_it_can_find_an_invoice_by_id
    result = @invoice_repo.find_by_id(2179)

    assert_instance_of Invoice, result
    assert_equal 2179, result.id
    assert_equal 433, result.customer_id
    assert_equal 12334633, result.merchant_id
    assert_equal :returned, result.status
  end

  def test_it_can_find_another_invoice_by_id
    result = @invoice_repo.find_by_id(4800)

    assert_instance_of Invoice, result
    assert_equal 4800, result.id
    assert_equal 963, result.customer_id
    assert_equal 12334183, result.merchant_id
    assert_equal :returned, result.status
  end

  def test_it_can_return_nil_when_there_is_no_match_for_id
    result = @invoice_repo.find_by_id(1234567)

    assert_nil result
  end

  def test_it_can_find_all_by_customer_id
    result = @invoice_repo.find_all_by_customer_id(206)

    assert result.class == Array
    assert_equal 4, result.length
    assert_instance_of Invoice, result.first
    assert_equal 1053, result.first.id
    assert_equal 12334141, result.last.merchant_id
  end

  def test_it_returns_empty_array_when_there_is_no_match_for_customer_id
    result = @invoice_repo.find_all_by_customer_id(2061222)

    assert_equal [], result
  end

  def test_it_can_find_all_by_merchant_id
    result = @invoice_repo.find_all_by_merchant_id(12334141)

    assert result.class == Array
    assert_equal 9, result.length
    assert_instance_of Invoice, result.first
    assert_equal 641, result.first.id
    assert_equal 206, result.last.customer_id
  end

  def test_it_returns_empty_array_when_there_is_no_match_for_merchant_id
    result = @invoice_repo.find_all_by_merchant_id(2061222)

    assert_equal [], result
  end

  def test_it_can_find_all_by_status
    result = @invoice_repo.find_all_by_status(:returned)

    assert result.class == Array
    assert_equal 4, result.length
    assert_instance_of Invoice, result.first
    assert_equal 1495, result.first.id
    assert_equal 12334213, result[2].merchant_id
    assert_equal 963, result.last.customer_id
  end

  def test_it_returns_empty_array_when_there_is_no_match_for_status
    result = @invoice_repo.find_all_by_status("notavalidstatus")

    assert_equal [], result
  end

end
