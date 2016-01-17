require_relative '../lib/invoice_repository'
require_relative '../lib/sales_engine'
require_relative 'spec_helper'
require          'pry'
require          'minitest/autorun'
require          'minitest/pride'


class InvoiceRepositoryTest < Minitest::Test

  def test_class_exist
    assert InvoiceRepository
  end

  def setup
  # sample_data
  @se = SalesEngine.from_csv({:invoices => "./data/invoice_sample.csv"})
  #   @se = SalesEngine.from_csv({
  #             :items     => "./data/items_sample.csv",
  #             :merchants => "./data/merchants_sample.csv",
  #                             })
  end

  def test_that_all_method_exist
    assert InvoiceRepository.method_defined? :all
  end

  def test_that_find_by_id_method_exist
    assert InvoiceRepository.method_defined? :find_by_id
  end

  def test_that_find_all_by_customer_id_method_exist
    assert InvoiceRepository.method_defined? :find_all_by_customer_id
  end

  def test_that_find_all_by_merchant_id_method_exist
    assert InvoiceRepository.method_defined? :find_all_by_merchant_id
  end

  def test_that_find_all_by_status_method_exist
    assert InvoiceRepository.method_defined? :find_all_by_status
  end

end
