require 'minitest'
require 'minitest/autorun'
# require 'minitest/emoji'
require_relative '../lib/invoice_repository'

class InvoiceRepositoryTest < Minitest::Test

  def setup
    @invoice_r = InvoiceRepository.new(self)
    hash_one   = {id: 123, merchant_id: 7, customer_id: 1,
                  status: "shipped"                       }
    hash_two   = {id: 123, merchant_id: 2, customer_id: 2,
                  status: "pending"                       }
    hash_three = {id: 124, merchant_id: 5, customer_id: 1,
                  status: "shipped"                       }
    hash_four  = {id: 125, merchant_id: 5, customer_id: 3,
                  status: "shipped"                       }
    @invoice_r.add_data(hash_one)
    @invoice_r.add_data(hash_two)
    @invoice_r.add_data(hash_three)
    @invoice_r.add_data(hash_four)
  end

  def test_it_exists
    i = InvoiceRepository.new(1)
    assert i
    assert_instance_of InvoiceRepository, i
  end

  def test_it_can_be_added_to
    ir = InvoiceRepository.new(1)
    hash_one = {status: "shipped",
                id: 1, merchant_id: 3}
    hash_two = {status: "pending",
                id: 2, merchant_id: 4}

    ir.add_data(hash_one)
    ir.add_data(hash_two)

    assert_equal 1        , ir.invoices.first.id
    assert_equal "shipped", ir.invoices.first.status
    assert_equal 3        , ir.invoices.first.merchant_id
    assert_equal 4        , ir.invoices.last.merchant_id
    assert_equal "pending", ir.invoices.last.status
    assert_equal 2        , ir.invoices.last.id
  end

  def test_all_is_working
    
end
