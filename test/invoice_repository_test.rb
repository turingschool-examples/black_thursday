require_relative 'test_helper'
require_relative '../lib/invoice_repository'

class InvoiceRepositoryTest < Minitest::Test
  def test_it_exists
    inv = stub('Inventory')
    Invoice.stubs(:from_raw_hash).returns(inv)
    repo = InvoiceRepository.new([{id: 0}])
    assert_instance_of InvoiceRepository, repo
  end

  def test_it_can_find_all_by_customer_id
    inv1 = stub('Invoice', id: 123, customer_id: 1234)
    inv2 = stub('Invoice', id: 456, customer_id: 4567)
    inv3 = stub('Invoice', id: 321, customer_id: 1234)
    Invoice.stubs(:from_raw_hash).returns(inv1, inv2, inv3)
    datas = [{id: 123}, {id: 456}, {id: 321}]
    repo = InvoiceRepository.new(datas)
    assert_equal([inv1, inv3], repo.find_all_by_customer_id(1234))
  end

  def test_it_can_find_all_by_status
    inv1 = stub('Invoice', id: 123, status: 'pending')
    inv2 = stub('Invoice', id: 456, status: 'shipped')
    inv3 = stub('Invoice', id: 321, status: 'returned')
    Invoice.stubs(:from_raw_hash).returns(inv1, inv2, inv3)
    datas = [{id: 123}, {id: 456}, {id: 321}]
    repo = InvoiceRepository.new(datas)
    assert_equal([inv2], repo.find_all_by_status('shipped'))
  end
end
