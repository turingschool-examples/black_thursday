require_relative './test_helper'
require './lib/invoice_repository'

class InvoiceRepositoryTest < Minitest::Test
    def setup
      invoices = [{
        :id => '24680',
        :customer_id => '12345',
        :merchant_id => '54321',
        :status => 'pending',
        :created_at => '2017-10-31',
        :updated_at => '2017-10-30'
        },{
        :id => '13579',
        :customer_id => '23456',
        :merchant_id => '65432',
        :status => 'shipped',
        :created_at => '2017-1-31',
        :updated_at => '2017-1-30'
        }]
      InvoiceRepository.new(invoices, self)
    end

    def test_setup_exists
      invoice_repo = setup

      assert_instance_of InvoiceRepository, invoice_repo
    end

    def test_invoice_repo_has_all_method
      invoice_repo = setup

      assert_equal 2, invoice_repo.all.count
    end

    def test_can_find_invoice_by_id
      invoice_repo = setup

      assert_equal '24680', invoice_repo.find_by_id('24680').id
      assert_equal '13579', invoice_repo.find_by_id('13579').id
      assert_nil invoice_repo.find_by_id("24524")
    end

    def test_can_find_invoice_by_customer_id
      invoice_repo = setup

      assert_equal [], invoice_repo.find_by_customer_id('10293')
      assert_equal 1, invoice_repo.find_by_customer_id('12345').count
    end

    def test_can_find_invoice_by_merchant_id
      invoice_repo = setup

      assert_equal [], invoice_repo.find_by_merchant_id('10293')
      assert_equal 1, invoice_repo.find_by_merchant_id('54321').count
    end

    def test_can_find_invoices_by_status
      invoice_repo = setup

      assert_equal 1, invoice_repo.find_all_by_status("shipped").count
      assert_equal 1, invoice_repo.find_all_by_status("pending").count
      assert_equal [], invoice_repo.find_all_by_status("cancelled")
    end
end
