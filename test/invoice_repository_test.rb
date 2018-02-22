# frozen_string_literal: true

require_relative 'test_helper'

require_relative '../lib/invoice_repository'

class InvoiceRepositoryTest < Minitest::Test
  def setup
    @invoice_repo = InvoiceRepository.new './test/fixtures/invoices.csv'
  end

  def test_does_create_repository
    assert_instance_of InvoiceRepository, @invoice_repo
  end

  def test_loads_invoices
    assert_equal 10, @invoice_repo.all.count
    assert_instance_of Array, @invoice_repo.all
    @invoice_repo.all.each do |invoice|
      assert_instance_of Invoice, invoice
    end
    assert_equal 1, @invoice_repo.all.first.customer_id
    assert_equal 3, @invoice_repo.all.first.merchant_id
  end

  def test_can_find_invoices_by_id
    result = @invoice_repo.find_by_id 1

    assert_instance_of Invoice, result
    assert_equal 1, result.customer_id
    assert_equal 3, result.merchant_id
    assert_equal 'pending', result.status
  end

end
