require 'simplecov'
SimpleCov.start

require 'time'
require 'csv'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/invoice_repository'

class InvoiceRepositoryTest < Minitest::Test
  def setup
    @sample_data = './test/fixtures/sample_invoices.csv'
  end

  def test_class_exists
    invoice_repo = InvoiceRepository.new(@sample_data, 'engine')

    assert_instance_of InvoiceRepository, invoice_repo
  end

  def test_all
    invoice_repo = InvoiceRepository.new(@sample_data, 'engine')

    assert_equal 10, invoice_repo.all.count
  end

  def test_it_can_find_by_id
    invoice_repo = InvoiceRepository.new(@sample_data, 'engine')

    assert_nil invoice_repo.find_by_id(11)
    assert_equal invoice_repo.invoices[0], invoice_repo.find_by_id(1)
  end

  def test_it_can_find_all_by_customer_id
    invoice_repo = InvoiceRepository.new(@sample_data, 'engine')

    expected = [invoice_repo.invoices[2], invoice_repo.invoices[5]]
    assert_equal expected, invoice_repo.find_all_by_customer_id(3)
  end

  def test_it_can_find_all_by_merchant_id
    invoice_repo = InvoiceRepository.new(@sample_data, 'engine')

    expected = [invoice_repo.invoices[2], invoice_repo.invoices[8]]
    assert_equal expected, invoice_repo.find_all_by_merchant_id(3)
  end

  def test_find_all_by_status
    invoice_repo = InvoiceRepository.new(@sample_data, 'engine')

    expected = [invoice_repo.invoices[4], invoice_repo.invoices[9]]
    assert_equal expected, invoice_repo.find_all_by_status(:returned)
  end

  def test_it_can_create
    invoice_repo = InvoiceRepository.new(@sample_data, 'engine')
    attributes = {
                  :customer_id => 7,
                  :merchant_id => 8,
                  :status      => 'pending',
                  :created_at  => Time.now,
                  :updated_at  => Time.now,
                  }

    invoice_repo.create(attributes)

    assert_equal invoice_repo.invoices.last, invoice_repo.find_by_id(11)
    assert_equal 11, invoice_repo.all.count
  end

  def test_it_can_update
    invoice_repo = InvoiceRepository.new(@sample_data, 'engine')
    time = Time.now.round
    attributes = {
                  :status => :shipped,
                  }

    invoice_repo.update(1, attributes)

    assert_equal :shipped, invoice_repo.find_by_id(1).status
    assert_equal time, invoice_repo.find_by_id(1).updated_at
    assert_nil invoice_repo.update(25, attributes)
  end

  def test_it_can_delete
    invoice_repo = InvoiceRepository.new(@sample_data, 'engine')

    invoice_repo.delete(1)

    assert_nil invoice_repo.find_by_id(1)
  end
end
