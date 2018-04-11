require_relative 'test_helper'
require_relative '../lib/invoice_repository'

class InvoiceRepositoryTest < Minitest::Test
  def setup
    @invr = InvoiceRepository.new
  end

  def test_it_exists
    @invr = InvoiceRepository.new
    assert_instance_of InvoiceRepository, @invr
  end

  def test_it_can_create_invoices_from_csv
    @invr.from_csv('./data/invoices.csv')
    # ('./test/fixtures/invoice_fixtures.csv')
    assert_equal 4985, @invr.elements.count
    assert_instance_of Invoice, @invr.elements[328]
    assert_equal 66, @invr.elements[328].customer_id
    assert_instance_of Invoice, @invr.elements[141]
    assert_equal :shipped, @invr.elements[141].status
    assert_equal 12334361, @invr.elements[237].merchant_id

    assert_nil @invr.elements['id']
    assert_nil @invr.elements[999999999]
    assert_nil @invr.elements[0]
    assert_instance_of Time, @invr.elements[346].created_at
    assert_instance_of Time, @invr.elements[989].updated_at
  end

  def test_all_method
    @invr.from_csv('./data/invoices.csv')
    all_invoices = @invr.all
    assert_equal 4985, all_invoices.count
    assert_instance_of Invoice, all_invoices[0]
    assert_instance_of Invoice, all_invoices[800]
    assert_instance_of Invoice, all_invoices[-1]
    assert_instance_of Array, all_invoices
  end

  def test_find_by_id
    @invr.from_csv('./data/invoices.csv')
    invoice = @invr.find_by_id(308)
    assert_instance_of Invoice, invoice
    assert_equal 60, invoice.customer_id

    invoice2 = @invr.find_by_id(1114)
    assert_instance_of Invoice, invoice2
    assert_equal 12335677, invoice2.merchant_id
    assert_nil @invr.find_by_id(12345678901234567890)
  end

  def test_find_all_by_customer_id
    @invr.from_csv('./data/invoices.csv')
    invoices = @invr.find_all_by_customer_id(2)
    assert_instance_of Array, invoices
    assert_instance_of Invoice, invoices[0]
    find = @invr.find_by_id(10)
    assert invoices.include?(find)
    assert_equal 4, invoices.count

    invoices2 = @invr.find_all_by_customer_id(255)
    assert_instance_of Array, invoices2
    find = @invr.find_by_id(1308)
    find2 = @invr.find_by_id(1315)
    find3 = @invr.find_by_id(1316)
    assert invoices2.include?(find)
    assert invoices2.include?(find2)
    refute invoices2.include?(find3)

    invoices3 = @invr.find_all_by_customer_id(9999999999)
    assert_equal [], invoices3
  end

  def test_find_all_by_merchant_id
    @invr.from_csv('./data/invoices.csv')
    invoices = @invr.find_all_by_merchant_id(12334434)
    assert_instance_of Array, invoices
    find = @invr.find_by_id(1303)
    assert invoices.include?(find)

    invoices2 = @invr.find_all_by_merchant_id(12334499)
    assert_instance_of Array, invoices2
    find = @invr.find_by_id(1351)
    find2 = @invr.find_by_id(400)
    find3 = @invr.find_by_id(485)
    assert invoices2.include?(find)
    assert invoices2.include?(find2)
    refute invoices2.include?(find3)

    invoices3 = @invr.find_all_by_merchant_id(9999999999)
    assert_equal [], invoices3
  end

  def test_find_all_by_status
    @invr.from_csv('./data/invoices.csv')
    invoices = @invr.find_all_by_status('shipped')
    assert_instance_of Array, invoices
    find = @invr.find_by_id(492)
    assert invoices.include?(find)

    invoices2 = @invr.find_all_by_status('returned')
    assert_instance_of Array, invoices2
    find = @invr.find_by_id(500)
    find2 = @invr.find_by_id(445)
    find3 = @invr.find_by_id(418)

    assert invoices2.include?(find)
    assert invoices2.include?(find2)
    refute invoices2.include?(find3)

    invoices3 = @invr.find_all_by_status('random gibberish')
    assert_equal [], invoices3
  end

  def test_it_can_create_a_new_invoice
    assert_equal 0, @invr.all.count
    time = Time.now
    @invr.create(
                  customer_id:  7,
                  merchant_id:  8,
                  status:       'pending',
                  created_at:   time,
                  updated_at:   time
                )
    assert_equal 1, @invr.all.count
    assert_equal :pending, @invr.find_by_id(1).status
    assert_equal time, @invr.find_by_id(1).updated_at

    @invr.create(
                  customer_id:  9,
                  merchant_id:  18,
                  status:       'shipping',
                  created_at:   time,
                  updated_at:   time
                )
    assert_equal 2, @invr.all.count
    assert_equal 18, @invr.find_by_id(2).merchant_id
  end

  def test_it_can_update_an_existing_invoice
    assert_equal 0, @invr.all.count
    time = Time.now - 1
    @invr.create(
                  customer_id:  7,
                  merchant_id:  8,
                  status:       'pending',
                  created_at:   time,
                  updated_at:   time
                )
    assert_equal 1, @invr.all.count
    assert_equal :pending, @invr.find_by_id(1).status
    assert_equal 8, @invr.find_by_id(1).merchant_id

    @invr.update(1, {
                      customer_id:  9,
                      merchant_id:  18,
                      status:       'shipping'
                    })
    assert_equal 1, @invr.all.count
    assert_equal :shipping, @invr.find_by_id(1).status
    assert_equal 18, @invr.find_by_id(1).merchant_id
    assert_equal 9, @invr.find_by_id(1).customer_id
    assert time < @invr.find_by_id(1).updated_at
  end

  def test_it_can_delete_an_existing_invoice
    assert_equal 0, @invr.all.count
    time = Time.now
    @invr.create(
                  customer_id:  7,
                  merchant_id:  8,
                  status:       'pending',
                  created_at:   time,
                  updated_at:   time
                )
    assert_equal 1, @invr.all.count
    assert_equal 7, @invr.find_by_id(1).customer_id

    @invr.delete(1)
    assert_equal 0, @invr.all.count
  end
end
