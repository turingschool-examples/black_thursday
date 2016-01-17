require_relative '../lib/invoice_repository'
require_relative 'spec_helper'
require          'pry'
require          'minitest/autorun'
require          'minitest/pride'


class InvoiceRepositoryTest < Minitest::Test
  attr_reader :sample

  def test_class_exist
    assert InvoiceRepository
  end

  def setup
    @sample = SalesEngine.from_csv({:invoices => "./data/invoice_sample.csv"})
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

  def test_that_the_all_method_returns_an_array
    repo = InvoiceRepository.new([
      {id: 1, description: "abc", unit_price: 1000, :created_at=>"2016-01-11 10:37:09 UTC", :updated_at=>"2016-01-11 10:37:09 UTC"},
      {id: 2, description: "a1c", unit_price: 1000, :created_at=>"2016-01-11 10:37:09 UTC", :updated_at=>"2016-01-11 10:37:09 UTC"},
      {id: 3, description: "1b2", unit_price: 1000, :created_at=>"2016-01-11 10:37:09 UTC", :updated_at=>"2016-01-11 10:37:09 UTC"},
    ])
    binding.pry
    assert_kind_of(Array, repo.all)
  end

end
