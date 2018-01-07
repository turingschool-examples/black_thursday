require "./test/test_helper"
require "./lib/invoice_repository"

class InvoiceRepositoryTest < Minitest::Test
  def setup
    @invoices = InvoiceRepository.new("./test/fixtures/invoices_fixtures.csv")
  end

  def test_all_returns_all_invoices
    assert_equal @invoices.invoices.values, @invoices.all
  end

  def test_find_by_id_returns_invoice
    assert_instance_of Invoice, @invoices.find_by_id(1553)

    assert_equal 307, @invoices.find_by_id(1553).customer_id
  end

  def test_find_by_id_returns_nil_when_passed_nonmatching_id
    assert_nil @invoices.find_by_id(13)
  end

  def test_argument_raised_if_find_by_id_is_passed_non_integer
    assert_raises ArgumentError do
      @invoices.find_by_id('carl')
    end

    assert_raises ArgumentError do
      @invoices.find_by_id([403, 404])
    end
  end

  def test_find_all_by_customer_id_returns_array_of_invoices
    assert_instance_of Array, @invoices.find_all_by_customer_id(174)

    assert_instance_of Invoice, @invoices.find_all_by_customer_id(174).first
    assert_equal 1, @invoices.find_all_by_customer_id(174).count
  end

  def test_find_all_by_customer_id_return_empty_array_if_passed_nonmatching_id
    assert @invoices.find_all_by_customer_id(3).empty?
  end

  def test_find_all_by_customer_id_raises_argumenterror_if_passed_non_integer
    assert_raises ArgumentError do
      @invoices.find_all_by_customer_id('carl')
    end

    assert_raises ArgumentError do
      @invoices.find_all_by_customer_id([3, 405])
    end
  end

  def test_find_all_by_merchant_id_returns_array_of_invoices
    assert_instance_of Array, @invoices.find_all_by_merchant_id(12335519)

    assert_instance_of Invoice, @invoices.find_all_by_merchant_id(12335519).first
    assert_equal 11, @invoices.find_all_by_merchant_id(12335519).count
  end

  def test_find_all_by_merchant_id_return_empty_array_if_passed_nonmatching_id
    assert @invoices.find_all_by_merchant_id(3).empty?
  end

  def test_find_all_by_merchant_id_raises_argumenterror_if_passed_non_integer
    assert_raises ArgumentError do
      @invoices.find_all_by_merchant_id('carl')
    end

    assert_raises ArgumentError do
      @invoices.find_all_by_merchant_id([3, 405])
    end
  end

  def test_find_all_by_status_returns_array_of_invoices
    assert_instance_of Array, @invoices.find_all_by_status(:pending)

    assert_instance_of Invoice, @invoices.find_all_by_status(:pending).first
    assert_equal 33, @invoices.find_all_by_status(:pending).count
  end

  def test_find_all_by_status_return_empty_array_if_passed_nonmatching_id
    assert @invoices.find_all_by_status(:silly).empty?
  end

  def test_find_all_by_status_raises_argumenterror_if_passed_non_symbol
    assert_raises ArgumentError do
      @invoices.find_all_by_status('carl')
    end

    assert_raises ArgumentError do
      @invoices.find_all_by_status([3, 405])
    end
  end

  def test_merchant_returns_instance_of_merchant
    skip
  end

  def test_inspect_returns_string
    assert_equal "#<InvoiceRepository 119 rows>", @invoices.inspect
  end
end
