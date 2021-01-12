require './test/test_helper'
require './lib/invoice_repo'
require './lib/sales_engine'
require './lib/cleaner'
require './lib/sales_engine'

class InvoiceRepositoryTest < MiniTest::Test

  def setup
    @sales_engine = SalesEngine.from_csv({items: "./data/items.csv"})
    @invoice_repo = InvoiceRepository.new(@sales_engine)
  end

  def test_it_exists
    assert_instance_of InvoiceRepository, @invoice_repo
  end

  def test_it_has_attributes
    assert_equal 4985, @invoice_repo.invoices.count
  end

  def test_all
    assert_equal 4985, @invoice_repo.all.count
  end

  def test_find_by_id
    invoice_id = 3452

    assert_equal 3452, @invoice_repo.find_by_id(invoice_id).id
  end

  def test_find_by_merchant_id
    merchant_id = 12335080
    expected = @invoice_repo.find_all_by_merchant_id(merchant_id)

    assert_equal 7, expected.length
  end

  def test_find_by_customer_id
    customer_id = 300
    expect = @invoice_repo.find_all_by_customer_id(customer_id).length

    assert_equal 10, expect
  end

  def test_find_all_by_status
    status = :shipped
    test = @invoice_repo.find_all_by_status(status)

    assert_equal 2839, test.length

    status = :pending
    test = @invoice_repo.find_all_by_status(status)

    assert_equal 1473, test.length

    status = :returned
    test = @invoice_repo.find_all_by_status(status)

    assert_equal 673, test.length

    status = :sold
    test = @invoice_repo.find_all_by_status(status)

    assert_equal [], test
  end

  def test_creates
    attributes = {
        :customer_id => 7,
        :merchant_id => 8,
        :status      => "pending",
        :created_at  => Time.now,
        :updated_at  => Time.now
      }
    @invoice_repo.create(attributes)
    test = @invoice_repo.find_by_id(4986)

    assert_equal 8, test.merchant_id
  end

  def test_updates
    attributes = {
      :customer_id => 7,
      :merchant_id => 8,
      :status      => "pending",
      :created_at  => Time.now,
      :updated_at  => Time.now}
    @invoice_repo.create(attributes)
    original_time = @invoice_repo.find_by_id(4986).updated_at
    attributes = {:status => :success}
    @invoice_repo.update(4986, attributes)
    test = @invoice_repo.find_by_id(4986)

    assert_equal :success, test.status
    assert_equal 7, test.customer_id
    assert_equal true, (test.updated_at > original_time)

    attributes = {
        id: 5000,
        customer_id: 2,
        merchant_id: 3,
        created_at: Time.now
      }
    @invoice_repo.update(4986, attributes)
    test = @invoice_repo.find_by_id(5000)

    assert_nil test
  end

  def test_count_invoices_per_weekday
    assert_equal 696, @invoice_repo.invoices_per_weekday[:monday].count
    assert_equal 692, @invoice_repo.invoices_per_weekday[:tuesday].count
    assert_equal 741, @invoice_repo.invoices_per_weekday[:wednesday].count
    assert_equal 718, @invoice_repo.invoices_per_weekday[:thursday].count
    assert_equal 701, @invoice_repo.invoices_per_weekday[:friday].count
    assert_equal 729, @invoice_repo.invoices_per_weekday[:saturday].count
    assert_equal 708, @invoice_repo.invoices_per_weekday[:sunday].count
  end

  def test_pending_status_by_merchant_id
    assert_equal 1473, @invoice_repo.status_by_merchant_id(:pending).count
    assert_equal 12335853, @invoice_repo.status_by_merchant_id(:pending).last
  end
end
