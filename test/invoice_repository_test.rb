require_relative 'test_helper'
require './lib/sales_engine'


class InvoiceRepositoryTest < Minitest::Test
  def setup
    @se = SalesEngine.from_csv( { :items     => './test/fixtures/items_truncated.csv',
                                  :merchants => './test/fixtures/merchants_truncated.csv',
                                  :invoices  => './test/fixtures/invoices_truncated.csv'
                                } )
    @ir = @se.invoices
  end

  def test_it_exists
    assert_instance_of InvoiceRepository, @ir
  end

  def test_it_has_invoices
    skip
    assert_equal 9, @ir.all.count
    assert_instance_of Array, @ir.all
  end

  def test_all
    skip
# all - returns an array of all known Invoice instances
    assert_instance_of Array, @ir.all
  end

  def test_find_by_id
    skip
    # find_by_id - returns either nil or an instance of Invoice with a matching ID
    assert_nil @ir.find_by_id(777)
    assert_instance_of Invoice, @ir.find_by_id(1)
  end

  def test_find_all_by_customer_id
    skip
    # find_all_by_customer_id - returns either [] or one or more matches which have a matching customer ID
    assert_instance_of Array, @ir.find_by_id(777)
    assert_instance_of Array, @ir.find_by_id(1)
    assert_instance_of Invoice, @ir.find_by_id(1)
  end

  def test_find_all_by_merchant_id
    skip
    # find_all_by_merchant_id - returns either [] or one or more matches which have a matching merchant ID
    assert_instance_of Array, @ir.find_by_id(777)
    assert_instance_of Array, @ir.find_by_id(1)
    assert_instance_of Invoice, @ir.find_by_id(1)
  end

  def test_find_all_by_status
    # find_all_by_status - returns either [] or one or more matches which have a matching status

  end

  def test_create_invoice
    # create(attributes) - create a new Invoice instance with the provided attributes. The new Invoice’s id should be the current highest Invoice id plus 1.

  end

  def test_update_invoice
    # update(id, attribute) - update the Invoice instance with the corresponding id with the provided attributes. Only the invoice’s status can be updated. This method will also change the invoice’s updated_at attribute to the current time.
  end

  def test_delete_invoice
    # delete(id) - delete the Invoice instance with the corresponding id
  end




#   all - returns an array of all known Invoice instances

end
