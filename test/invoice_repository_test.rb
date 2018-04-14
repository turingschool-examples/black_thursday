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
    @invr.from_csv('./test/fixtures/invoices_fixtures.csv')
    assert_equal 50, @invr.elements.count
    assert_instance_of Invoice, @invr.elements[32]
    assert_equal 7, @invr.elements[32].customer_id
    assert_instance_of Invoice, @invr.elements[40]
    assert_equal :pending, @invr.elements[48].status
    assert_equal 12336299, @invr.elements[50].merchant_id

    assert_nil @invr.elements['id']
    assert_nil @invr.elements[999999999]
    assert_nil @invr.elements[0]
    assert_instance_of Time, @invr.elements[34].created_at
    assert_instance_of Time, @invr.elements[9].updated_at
  end

  def test_all_method
    @invr.from_csv('./test/fixtures/invoices_fixtures.csv')
    all_invoices = @invr.all
    assert_equal 50, all_invoices.count
    assert_instance_of Invoice, all_invoices[0]
    assert_instance_of Invoice, all_invoices[8]
    assert_instance_of Invoice, all_invoices[-1]
    assert_instance_of Array, all_invoices
  end

  def test_find_by_id
    @invr.from_csv('./test/fixtures/invoices_fixtures.csv')
    invoice = @invr.find_by_id(38)
    assert_instance_of Invoice, invoice
    assert_equal 9, invoice.customer_id

    invoice2 = @invr.find_by_id(14)
    assert_instance_of Invoice, invoice2
    assert_equal 12335150, invoice2.merchant_id
    assert_nil @invr.find_by_id(12345678901234567890)
  end

  def test_find_all_by_customer_id
    @invr.from_csv('./test/fixtures/invoices_fixtures.csv')
    invoices = @invr.find_all_by_customer_id(2)
    assert_instance_of Array, invoices
    assert_instance_of Invoice, invoices[0]
    find = @invr.find_by_id(10)
    assert invoices.include?(find)
    assert_equal 4, invoices.count

    invoices2 = @invr.find_all_by_customer_id(7)
    assert_instance_of Array, invoices2
    find = @invr.find_by_id(29)
    find2 = @invr.find_by_id(32)
    find3 = @invr.find_by_id(33)
    assert invoices2.include?(find)
    assert invoices2.include?(find2)
    refute invoices2.include?(find3)

    invoices3 = @invr.find_all_by_customer_id(9999999999)
    assert_equal [], invoices3
  end

  def test_find_all_by_merchant_id
    @invr.from_csv('./test/fixtures/invoices_fixtures.csv')
    invoices = @invr.find_all_by_merchant_id(12334488)
    assert_instance_of Array, invoices
    find = @invr.find_by_id(40)
    assert invoices.include?(find)

    invoices2 = @invr.find_all_by_merchant_id(12335955)
    assert_instance_of Array, invoices2
    find = @invr.find_by_id(3)
    find2 = @invr.find_by_id(13)
    find3 = @invr.find_by_id(40)
    assert invoices2.include?(find)
    assert invoices2.include?(find2)
    refute invoices2.include?(find3)

    invoices3 = @invr.find_all_by_merchant_id(9999999999)
    assert_equal [], invoices3
  end

  def test_find_all_by_status
    @invr.from_csv('./test/fixtures/invoices_fixtures.csv')
    invoices = @invr.find_all_by_status('shipped')
    assert_instance_of Array, invoices
    find = @invr.find_by_id(29)
    assert invoices.include?(find)

    invoices2 = @invr.find_all_by_status('returned')
    assert_instance_of Array, invoices2
    find = @invr.find_by_id(49)
    find2 = @invr.find_by_id(37)
    find3 = @invr.find_by_id(29)

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
      assert_equal 7, @invr.find_by_id(1).customer_id
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
