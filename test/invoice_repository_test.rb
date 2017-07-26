require 'bigdecimal'
require_relative '../lib/invoice_repository'
require_relative '../lib/sales_engine'
require 'csv'
require 'minitest/autorun'
require 'minitest/emoji'

class InvoiceRepositoryTest < Minitest::Test
  def setup
    @se = SalesEngine.from_csv({
              :items => "./test/data/items_fixture.csv",
              :merchants => "./test/data/merchants_fixture.csv",
              :invoice_items => "./test/data/invoice_items_fixture.csv",
              :invoices => "./test/data/invoices_fixture.csv",
              :transactions => "./test/data/transactions_fixture.csv",
              :customers => "./test/data/customers_fixture.csv"
            })
    @ir = @se.invoices
  end

  def test_invoice_repo_exists
    assert_instance_of InvoiceRepository, @ir
  end

  def test_all_findbyid_findallbycustid_findallmerchid_findallbystatus
    assert_instance_of Array, @ir.all

    assert_instance_of Invoice, @ir.find_by_id(2)
    assert_instance_of Array, @ir.find_all_by_customer_id(2)
    assert_instance_of Invoice, @ir.find_all_by_customer_id(2)[0]
    assert_equal 4, @ir.find_all_by_customer_id(2).count

    assert_instance_of Array, @ir.find_all_by_merchant_id(12334185)
    assert_instance_of Invoice, @ir.find_all_by_merchant_id(12335311)[0]
    assert_equal 1, @ir.find_all_by_merchant_id(12335311).count

    assert_instance_of Array, @ir.find_all_by_status("pending")
    assert_instance_of Invoice, @ir.find_all_by_status("pending")[0]
    assert_equal 162, @ir.find_all_by_status("pending").count
  end

  # def test_find_all_by_merchant_id
  #   assert_equal 6, @ir.find_all_by_merchant_id(12334185).count
  #   assert_equal [], @ir.find_all_by_merchant_id(6546546546)
  # end

end
