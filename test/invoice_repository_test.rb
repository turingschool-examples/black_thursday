require 'minitest'
require 'minitest/autorun'
# require 'minitest/emoji'
require_relative '../lib/invoice_repository'

class InvoiceRepositoryTest < Minitest::Test
  def test_it_exists
    i = InvoiceRepository.new
    assert i
    assert_instance_of InvoiceRepository, i
  end

  def test_it_can_be_added_to
    ir = InvoiceRepository.new
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
end
