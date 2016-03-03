gem 'minitest', '~> 5.2'
require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/invoice'
require_relative '../lib/invoice_repository'
require_relative '../lib/sales_engine'

class InvoiceRepositoryClassTest < Minitest::Test

attr_accessor :invoices, :se, :invoice_1, :invoice_2, :invoice_3, :invoice_4, :invoice_5, :invoice_6, :invoice_7, :invoice_8, :invoice_9

  def setup

    @se = SalesEngine.from_csv({
      :items     => "test/fake_items.csv",
      :merchants => "test/fake_merchants.csv",
      :invoices => "test/fake_invoices.csv"
    })

    @invoices = InvoiceRepository.new(@se)

    @invoice_1 = Invoice.new(@se, {:id => "1",
                            :customer_id => "1",
                            :merchant_id => "120",
                            :status => "pending",
                            :created_at => "2009-02-07",
                            :updated_at => "2014-03-15"})

    @invoice_2 = Invoice.new(@se, {:id => "2",
                            :customer_id => "1",
                            :merchant_id => "120",
                            :status => "shipped",
                            :created_at => "2012-11-23",
                            :updated_at => "2013-04-14"})

    @invoice_3 = Invoice.new(@se, {:id => "3",
                            :customer_id => "1",
                            :merchant_id => "121",
                            :status => "shipped",
                            :created_at => "2009-12-09",
                            :updated_at => "2010-07-10"})

    @invoice_4 = Invoice.new(@se, {:id => "4",
                            :customer_id => "1",
                            :merchant_id => "122",
                            :status => "pending",
                            :created_at => "2013-08-05",
                            :updated_at => "2014-06-06"})

    @invoice_5 = Invoice.new(@se, {:id => "5",
                            :customer_id => "1",
                            :merchant_id => "123",
                            :status => "pending",
                            :created_at => "2014-02-08",
                            :updated_at => "2014-07-22"})

    @invoice_6 = Invoice.new(@se, {:id => "6",
                            :customer_id => "1",
                            :merchant_id => "124",
                            :status => "pending",
                            :created_at => "2015-03-13",
                            :updated_at => "2015-04-05"})

    @invoice_7 = Invoice.new(@se, {:id => "7",
                            :customer_id => "1",
                            :merchant_id => "125",
                            :status => "pending",
                            :created_at => "2006-10-16",
                            :updated_at => "2013-12-24"})

    @invoice_8 = Invoice.new(@se, {:id => "8",
                            :customer_id => "1",
                            :merchant_id => "126",
                            :status => "shipped",
                            :created_at => "2003-11-07",
                            :updated_at => "2004-07-31"})

    @invoice_9 = Invoice.new(@se, {:id => "12",
                            :customer_id => "2",
                            :merchant_id => "125",
                            :status => "shipped",
                            :created_at => "2014-05-06",
                            :updated_at => "2014-10-06"})
  end

  def test_can_create_an_invoice_repository
    assert InvoiceRepository.new
  end

  def test_can_find_an_invoice_by_its_id
    # skip
    assert_equal invoice_1, se.invoices.find_by_id(1)
    assert_equal invoice_2, se.invoices.find_by_id(2)
    assert_equal invoice_8, se.invoices.find_by_id(8)
    assert_equal nil, se.invoices,find_by_id(100)
  end

  def test_can_find_all_by_customer_id
    # skip
    assert_equal [invoice_1, invoice_2, invoice_3, invoice_4, invoice_5, invoice_6, invoice_7, invoice_8], se.invoices.find_all_by_customer_id(1)
    assert_equal [], se.invoices.find_all_by_customer_id(100)

  end

  def test_can_find_all_by_merchant_id
    # skip
    assert_equal [invoice_7, invoice_9], se.invoices.find_all_by_merchant_id(125)
    assert_equal [], se.invoices.find_all_by_merchant_id(150)
  end

  def test_can_find_all_by_status
    # skip
    assert_equal [invoice_2, invoice_3, invoice_8, invoice_9], se.invoices.find_all_by_status("shipped")
    assert_equal [], se.invoices.find_all_by_status("completed")
  end

end
