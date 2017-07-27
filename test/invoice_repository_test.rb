require 'minitest/autorun'
require 'minitest/emoji'
require './lib/invoice_repository.rb'
require 'pry'

class InvoiceRepositoryTest < Minitest::Test

  def test_it_exists
    inr = InvoiceRepository.new('./data/invoices.csv', self)

    assert_instance_of InvoiceRepository, inr
  end

  def test_it_can_return_array_of_all_invoices
    inr = InvoiceRepository.new('./data/invoices.csv', self)

    target = inr.all

    assert_equal 4985, target.count
    assert_equal Array, target.class
  end

  def test_it_can_find_by_id
    inr = InvoiceRepository.new('./data/invoices.csv', self)

    target = inr.find_by_id(6)
    target_2 = inr.find_by_id(00000000)

    assert_equal 1, target.customer_id
    assert_nil target_2
  end
#
#   def test_it_can_find_all_by_customer_id
#     skip
#     ir = ItemRepository.new('./data/items.csv', self)
#
#     target = ir.find_all_by_merchant_id(12334141)
#     target_2 = ir.find_all_by_merchant_id("0")
#
#     assert_equal "510+ RealPush Icon Set", target[0].name
#     assert_equal Array, target.class
#     assert_equal [], target_2
#   end
#
#   def test_it_can_find_all_by_merchant_id
#     skip
#     ir = ItemRepository.new('./data/items.csv', self)
#
#     target = ir.find_all_by_merchant_id(12334141)
#     target_2 = ir.find_all_by_merchant_id("0")
#
#     assert_equal "510+ RealPush Icon Set", target[0].name
#     assert_equal Array, target.class
#     assert_equal [], target_2
#   end
#
#   def test_it_can_find_all_by_status
#     skip
#     ir = ItemRepository.new('./data/items.csv', self)
#
#     target = ir.find_all_by_merchant_id(12334141)
#     target_2 = ir.find_all_by_merchant_id("0")
#
#     assert_equal "510+ RealPush Icon Set", target[0].name
#     assert_equal Array, target.class
#     assert_equal [], target_2
#   end
end