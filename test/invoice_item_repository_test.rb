require_relative 'test_helper'
require_relative '../lib/invoice_item_repository'

class InvoiceItemRepositoryTest < Minitest::Test
  def setup
    @inv_itr = InvoiceItemRepository.new
  end

  def test_it_exists
    @inv_itr = InvoiceItemRepository.new
    assert_instance_of InvoiceItemRepository, @inv_itr
  end

  def test_it_can_create_invoice_items_from_csv
    skip
    @inv_itr.from_csv('./data/invoice_items.csv')
    # ('./test/fixtures/invoice_fixtures.csv')
    assert_equa_itr 4985, @inv_itr.elements.count
    assert_instance_of InvoiceItem, @inv_itr.elements[328]
    assert_equa_itr 66, @inv_itr.elements[328].customer_id
    assert_instance_of InvoiceItem, @inv_itr.elements[141]
    assert_equa_itr :shipped, @inv_itr.elements[141].status
    assert_equa_itr 12334361, @inv_itr.elements[237].merchant_id

    assert_nil @inv_itr.elements['id']
    assert_nil @inv_itr.elements[999999999]
    assert_nil @inv_itr.elements[0]
    assert_instance_of Time, @inv_itr.elements[346].created_at
    assert_instance_of Time, @inv_itr.elements[989].updated_at
  end

  def test_all_method
    skip
    @inv_itr.from_csv('./data/invoices.csv')
    all_invoices = @inv_itr.all
    assert_equa_itr 4985, all_invoices.count
    assert_instance_of InvoiceItem, all_invoices[0]
    assert_instance_of InvoiceItem, all_invoices[800]
    assert_instance_of InvoiceItem, all_invoices[-1]
    assert_instance_of Array, all_invoices
  end

  def test_find_by_id
    skip
    @inv_itr.from_csv('./data/invoices.csv')
    invoice = @inv_itr.find_by_id(308)
    assert_instance_of InvoiceItem, invoice
    assert_equa_itr 60, invoice.customer_id

    invoice2 = @inv_itr.find_by_id(1114)
    assert_instance_of InvoiceItem, invoice2
    assert_equal 12335677, invoice2.merchant_id
    assert_nil @inv_itr.find_by_id(12345678901234567890)
  end

  def test_find_all_by_customer_id
    skip
    @inv_itr.from_csv('./data/invoices.csv')
    invoices = @inv_itr.find_all_by_customer_id(2)
    assert_instance_of Array, invoices
    assert_instance_of InvoiceItem, invoices[0]
    find = @inv_itr.find_by_id(10)
    assert invoices.include?(find)
    assert_equal 4, invoices.count

    invoices2 = @inv_itr.find_all_by_customer_id(255)
    assert_instance_of Array, invoices2
    find = @inv_itr.find_by_id(1308)
    find2 = @inv_itr.find_by_id(1315)
    find3 = @inv_itr.find_by_id(1316)
    assert invoices2.include?(find)
    assert invoices2.include?(find2)
    refute invoices2.include?(find3)

    invoices3 = @inv_itr.find_all_by_customer_id(9999999999)
    assert_equal [], invoices3
  end

  def test_find_all_by_merchant_id
    skip
    @inv_itr.from_csv('./data/invoices.csv')
    invoices = @inv_itr.find_all_by_merchant_id(12334434)
    assert_instance_of Array, invoices
    find = @inv_itr.find_by_id(1303)
    assert invoices.include?(find)

    invoices2 = @inv_itr.find_all_by_merchant_id(12334499)
    assert_instance_of Array, invoices2
    find = @inv_itr.find_by_id(1351)
    find2 = @inv_itr.find_by_id(400)
    find3 = @inv_itr.find_by_id(485)
    assert invoices2.include?(find)
    assert invoices2.include?(find2)
    refute invoices2.include?(find3)

    invoices3 = @inv_itr.find_all_by_merchant_id(9999999999)
    assert_equal [], invoices3
  end

  def test_find_all_by_status
    skip
    @inv_itr.from_csv('./data/invoices.csv')
    invoices = @inv_itr.find_all_by_status('shipped')
    assert_instance_of Array, invoices
    find = @inv_itr.find_by_id(492)
    assert invoices.include?(find)

    invoices2 = @inv_itr.find_all_by_status('returned')
    assert_instance_of Array, invoices2
    find = @inv_itr.find_by_id(500)
    find2 = @inv_itr.find_by_id(445)
    find3 = @inv_itr.find_by_id(418)

    assert invoices2.include?(find)
    assert invoices2.include?(find2)
    refute invoices2.include?(find3)

    invoices3 = @inv_itr.find_all_by_status('random gibberish')
    assert_equal [], invoices3
  end

  def test_it_can_create_a_new_invoice
    skip
    assert_equal 0, @inv_itr.all.count
    time = Time.now
    @inv_itr.create(
                  customer_id:  7,
                  merchant_id:  8,
                  status:       'pending',
                  created_at:   time,
                  updated_at:   time
                )
    assert_equal 1, @inv_itr.all.count
    assert_equal :pending, @inv_itr.find_by_id(1).status
    assert_equal time, @inv_itr.find_by_id(1).updated_at

    @inv_itr.create(
                  customer_id:  9,
                  merchant_id:  18,
                  status:       'shipping',
                  created_at:   time,
                  updated_at:   time
                )
    assert_equal 2, @inv_itr.all.count
    assert_equal 18, @inv_itr.find_by_id(2).merchant_id
  end

  def test_it_can_update_an_existing_invoice
    skip
    assert_equal 0, @inv_itr.all.count
    time = Time.now - 1
    @inv_itr.create(
                  customer_id:  7,
                  merchant_id:  8,
                  status:       'pending',
                  created_at:   time,
                  updated_at:   time
                )
    assert_equal 1, @inv_itr.all.count
    assert_equal :pending, @inv_itr.find_by_id(1).status
    assert_equal 8, @inv_itr.find_by_id(1).merchant_id

    @inv_itr.update(1, {
                      customer_id:  9,
                      merchant_id:  18,
                      status:       'shipping'
                    })
    assert_equal 1, @inv_itr.all.count
    assert_equal :shipping, @inv_itr.find_by_id(1).status
    assert_equal 18, @inv_itr.find_by_id(1).merchant_id
    assert_equal 9, @inv_itr.find_by_id(1).customer_id
    assert time < @inv_itr.find_by_id(1).updated_at
  end

  def test_it_can_delete_an_existing_invoice
    skip
    assert_equal 0, @inv_itr.all.count
    time = Time.now
    @inv_itr.create(
                  customer_id:  7,
                  merchant_id:  8,
                  status:       'pending',
                  created_at:   time,
                  updated_at:   time
                )
    assert_equal 1, @inv_itr.all.count
    assert_equal 7, @inv_itr.find_by_id(1).customer_id

    @inv_itr.delete(1)
    assert_equal 0, @inv_itr.all.count
  end
end
