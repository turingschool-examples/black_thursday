require_relative 'test_helper'
require_relative '../lib/invoice_repo'

class InvoiceRepoTest < Minitest::Test

  def setup
    invoice_array = [{:id=>"4972", :customer_id=>"996", :merchant_id=>"12335055", :status=>"shipped", :created_at=>"2009-01-12", :updated_at=>"2013-12-30"},
    {:id=>"4973", :customer_id=>"996", :merchant_id=>"12336035", :status=>"shipped", :created_at=>"2002-09-14", :updated_at=>"2006-12-17"},
    {:id=>"4974", :customer_id=>"998", :merchant_id=>"12334315", :status=>"shipped", :created_at=>"2010-01-21", :updated_at=>"2014-06-20"},
    {:id=>"4975", :customer_id=>"998", :merchant_id=>"12334183", :status=>"shipped", :created_at=>"2010-08-24", :updated_at=>"2014-05-04"},
    {:id=>"4976", :customer_id=>"998", :merchant_id=>"12335853", :status=>"shipped", :created_at=>"2004-01-02", :updated_at=>"2006-06-15"},
    {:id=>"4977", :customer_id=>"999", :merchant_id=>"12335021", :status=>"shipped", :created_at=>"2010-01-06", :updated_at=>"2015-05-25"},
    {:id=>"4978", :customer_id=>"999", :merchant_id=>"12337207", :status=>"shipped", :created_at=>"2000-09-05", :updated_at=>"2009-10-22"},
    {:id=>"4979", :customer_id=>"999", :merchant_id=>"12336749", :status=>"shipped", :created_at=>"2012-08-26", :updated_at=>"2015-06-02"},
    {:id=>"4980", :customer_id=>"999", :merchant_id=>"12335493", :status=>"shipped", :created_at=>"2007-12-05", :updated_at=>"2011-02-22"},
    {:id=>"4981", :customer_id=>"999", :merchant_id=>"12335252", :status=>"returned", :created_at=>"2009-07-07", :updated_at=>"2012-07-04"},
    {:id=>"4982", :customer_id=>"999", :merchant_id=>"12334146", :status=>"shipped", :created_at=>"2009-05-29", :updated_at=>"2014-10-02"},
    {:id=>"4983", :customer_id=>"999", :merchant_id=>"12334553", :status=>"shipped", :created_at=>"2001-01-13", :updated_at=>"2003-10-13"},
    {:id=>"4984", :customer_id=>"999", :merchant_id=>"12335541", :status=>"returned", :created_at=>"2009-10-15", :updated_at=>"2010-01-21"},
    {:id=>"4985", :customer_id=>"999", :merchant_id=>"12335541", :status=>"shipped", :created_at=>"2004-04-12", :updated_at=>"2014-01-27"}]

    @invoice_repo = InvoiceRepo.new(invoice_array)
  end

  def test_it_exists
    assert_instance_of InvoiceRepo, @invoice_repo
  end

  def test_it_returns_all_invoices
    assert_equal @invoice_repo.invoices, @invoice_repo.all
  end

  def test_it_finds_invoice_by_id
    assert_equal @invoice_repo.invoices[0], @invoice_repo.find_by_id(4972)
    assert_equal nil, @invoice_repo.find_by_id(1234)
  end

  def test_it_finds_all_invoices_by_cutomer_id
    assert_equal [@invoice_repo.invoices[0], @invoice_repo.invoices[1]], @invoice_repo.find_all_by_customer_id(996)
    assert_equal [], @invoice_repo.find_all_by_customer_id(1234)
  end

  def test_it_finds_all_invoices_by_merchant_id
    assert_equal [@invoice_repo.invoices[12], @invoice_repo.invoices[13]], @invoice_repo.find_all_by_merchant_id(12335541)
    assert_equal [], @invoice_repo.find_all_by_merchant_id(12345678)
  end

  def test_it_finds_all_by_status
    assert_equal [@invoice_repo.invoices[9], @invoice_repo.invoices[12]], @invoice_repo.find_all_by_status("returned")
    assert_equal [], @invoice_repo.find_all_by_status("pending")
  end

  def test_it_creates_invoice_with_attributes
    refute_instance_of Invoice, @invoice_repo.invoices[14]

    @invoice_repo.create({id:           6,
                          customer_id:  7,
                          merchant_id:  8,
                          status:       "pending",
                          created_at:   Time.now,
                          updated_at:   Time.now
                         })

    assert_instance_of Invoice, @invoice_repo.invoices[14]
  end

  def test_it_updates_invoice_attributes
    refute_equal "returned", @invoice_repo.invoices[13].status
    @invoice_repo.update(4985, {id:           6,
                                customer_id:  7,
                                merchant_id:  8,
                                status:       "shipped",
                                created_at:   Time.now,
                                updated_at:   Time.now
                                })
    assert_equal "shipped", @invoice_repo.invoices[13].status
  end

  def test_it_deletes_invoice_by_id
    assert_equal 4983, @invoice_repo.invoices[11].id
    @invoice_repo.delete(4983)
    assert_equal nil, @invoice_repo.find_by_id(4983)
  end
  
end
