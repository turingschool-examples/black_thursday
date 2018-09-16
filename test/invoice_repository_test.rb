require_relative 'test_helper'

# TO DO  - change these to require require_relative
require './lib/invoice'
require './lib/invoice_repository'


class InvoiceRepositoryTest < Minitest::Test

  def setup
    path = './data/invoices.csv'
    @repo = InvoiceRepository.new(path)
    @first = @repo.all[0]
    # ===== Invoice Examples =================
    # id,customer_id,merchant_id,status,created_at,updated_at
          # 1,1,12335938,pending,2009-02-07,2014-03-15
          # 2,1,12334753,shipped,2012-11-23,2013-04-14
    invoice_1_hash = { "1" => { customer_id: "1",
                                 merchant_id: "12335938",
                                 status:      "pending",
                                 created_at:  "2009-02-07",
                                 updated_at:  "2014-03-15"
                                } }
    @key = invoice_1_hash.keys[0]
    @values = invoice_1_hash.values[0]
  end



  def test_it_exists
    assert_instance_of InvoiceRepository, @repo
  end

  def test_it_makes_and_gets_invoices
    assert_instance_of Array, @repo.all
    assert_instance_of Invoice, @first
    assert_operator 1, :<=, @repo.all.count
  end

  def test_it_makes_invoices
    assert_equal 1,  @first.id
    assert_equal 1,  @first.customer_id
    assert_equal 12335938,  @first.merchant_id
    assert_equal :pending, @first.status
    assert_equal "2009-02-07", @first.created_at
    assert_equal "2014-03-15", @first.updated_at
  end

  def test_it_makes_a_formatted_hash
    # -- The new hash needs an additional column --
    new_column = {:id => 1}
    new_hash = new_column.merge(@values.dup)
    assert_equal new_hash, @repo.make_hash(@key, @values)
  end

  def test_it_can_find_an_invoice_by_id
    assert_nil @repo.find_by_id("000")
    assert_equal 1, @repo.find_by_id(1).id
    assert_equal 2, @repo.find_by_id(2).id
  end

  def test_it_can_find_all_invoices_by_customer_id
    assert_equal [], @repo.find_all_by_customer_id(0000)
    found = @repo.find_all_by_customer_id(1)
    assert_instance_of Array, found
    assert_instance_of Invoice, found.first
    assert_equal 1, found.first.customer_id
  end

  def test_it_can_find_all_invoices_by_merchant_id
    assert_equal [], @repo.find_all_by_merchant_id(0000)
    found = @repo.find_all_by_merchant_id(12335938)
    assert_instance_of Array, found
    assert_instance_of Invoice, found.first
    assert_equal 12335938, found.first.merchant_id
  end

  def test_it_can_find_all_invoices_by_status
    assert_equal [], @repo.find_all_by_status(:fake)
    found = @repo.find_all_by_status(:pending)
    assert_instance_of Array, found
    assert_instance_of Invoice, found.first
    assert_equal :pending, found.first.status
  end

end
