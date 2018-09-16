require_relative 'test_helper'


require_relative '../lib/sales_engine'
require_relative '../lib/invoice'
require_relative '../lib/invoice_repository'

class InvoiceRepositoryTest < Minitest::Test

  def setup
    path = {:invoices => './data/invoices.csv'}
    @repo = SalesEngine.from_csv(path).invoices
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
    @key = invoice_1_hash.keys.first
    @values = invoice_1_hash.values.first
  end



  def test_it_exists
    assert_instance_of InvoiceRepository, @repo
  end

  def test_it_gets_attributes
    # --- Read Only ---
    assert_instance_of Array, @repo.all
    assert_instance_of Invoice, @repo.all.first
    assert_equal @repo.all.count, @repo.all.uniq.count
    assert_operator 1, :<=, @repo.all.count
  end

  def test_it_makes_a_formatted_hash
    # -- The new hash needs an additional column --
    new_column = {:id => 1}
    new_hash = new_column.merge(@values.dup)
    assert_equal new_hash, @repo.make_hash(@key, @values)
  end


  # --- Find By ---

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
