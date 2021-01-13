require 'minitest/autorun'
require 'minitest/pride'
require './lib/invoice'
require './lib/invoice_repository'
require './lib/sales_engine'

class InvoiceRepositoryTest < Minitest::Test
  def setup
    merchant_path = './data/merchants.csv'
    item_path = './data/items.csv'
    invoice_items_path = './data/invoice_items.csv'
    customers_path = './data/customers.csv'
    transactions_path = './data/transactions.csv'
    invoices_path = './data/invoices.csv'
    locations = { items: item_path,
                  merchants: merchant_path,
                  invoice_items: invoice_items_path,
                  customers: customers_path,
                  transactions: transactions_path,
                  invoices: invoices_path }
    @engine = SalesEngine.new(locations)
    @ir = InvoiceRepository.new('./data/invoices.csv', @engine)
  end

  def test_it_has_attributes
    assert_instance_of InvoiceRepository, @ir
    assert_equal './data/invoices.csv', @ir.path
  end

  def test_it_read_invoices
    assert_equal 4985, @ir.invoices.count
  end

  def test_returns_all
    assert_equal 4985, @ir.all.count
  end

  def test_find_by_id_returns_correct_invoice
    invoice = @ir.find_by_id(3452)

    assert_equal 12_335_690, invoice.merchant_id
  end

  def test_find_by_customer_id_returns_correct_invoices
    invoices = @ir.find_all_by_customer_id(300)

    assert_equal 10, invoices.length
  end

  def test_find_by_merchant_id_returns_correct_invoices
    invoices = @ir.find_all_by_merchant_id(12_335_690)

    assert_equal 16, invoices.length
  end

  def test_find_all_by_status
    invoices = @ir.find_all_by_status(:shipped)

    assert_equal 2839, invoices.length
  end

  def test_create_invoice
    invoice = @ir.create({
                           customer_id: 7,
                           merchant_id: 8,
                           status: 'pending',
                           created_at: Time.now.to_s,
                           updated_at: Time.now.to_s
                         })

    assert_equal 8, @ir.find_by_id(4986).merchant_id
  end

  def test_update_invoice
    @ir.update(3452, { status: :shipped })

    assert_equal :shipped, @ir.find_by_id(3452).status
  end

  def test_delete_invoice
    assert_equal 3452, @ir.find_by_id(3452).id

    @ir.delete(3452)

    assert_nil @ir.find_by_id(3452)
  end

  def test_returns_per_merchant_invoice_count
    assert_equal 475, @ir.per_merchant_invoice_count.length
  end

  def test_returns_invoices_per_day
    days = { 'Monday' => 696,
             'Tuesday' => 692,
             'Wednesday' => 741,
             'Thursday' => 718,
             'Friday' => 701,
             'Saturday' => 729,
             'Sunday' => 708 }

    assert_equal days, @ir.invoices_per_day
  end

  def test_invoices_per_status
    status = { pending: 1473,
               shipped: 2839,
               returned: 673 }

    assert_equal status, @ir.invoices_per_status
  end

  def test_it_can_find_all_by_created_date
    assert_equal 1, @ir.find_all_by_date(Time.parse('2009-02-07')).length
  end

  def test_it_can_create_merchant_id_hash
    assert_equal 475, @ir.create_merchant_id_hash.length
  end
end
