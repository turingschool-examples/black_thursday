require_relative '../lib/invoice_repository'
require_relative '../lib/invoice'
require_relative './test_helper'

class InvoiceRepositoryTest < Minitest::Test
  def setup
    @invoices =
      [{id: 1,
      customer_id: 1,
      merchant_id: 12335938,
      status: 'pending',
      created_at: '2010-11-10',
      updated_at: '2011-11-04'},
      {id: 2,
      customer_id: 2,
      merchant_id: 12377738,
      status: 'pending',
      created_at: '2013-12-10',
      updated_at: '2013-12-04'},
      {id: 3,
      customer_id: 3,
      merchant_id: 12335888,
      status: 'shipped',
      created_at: '2010-03-10',
      updated_at: '2011-03-04'}]

    @invoice_repository = InvoiceRepository.new(@invoices)
  end

  def test_it_exist
    assert_instance_of InvoiceRepository, @invoice_repository
  end

  def test_it_can_build_invoice
    assert_equal Array, @invoice_repository.build_invoice(@invoices).class
  end

  def test_can_get_an_array_of_invoices
    assert_equal 3, @invoice_repository.all.count
  end

  def test_it_can_find_a_invoice_by_a_valid_id
    invoice = @invoice_repository.find_by_id(1)
    assert_instance_of Invoice, invoice
    assert_equal 1, invoice.id
  end
  #
  # def test_it_returns_nil_if_invoice_id_is_invalid
  #   invoice = @invoice_repository.find_by_id('invalid')
  #   assert_nil invoice
  # end
  #
  # def test_it_can_find_a_invoice_by_name
  #   invoice = @invoice_repository.find_by_name('Candisart')
  #   assert_instance_of Invoice, invoice
  #   assert_equal 'Candisart', invoice.name
  # end
  #
  # def test_it_returns_nil_if_merchant_name_is_invalid
  #   merchant = @merchant_repository.find_by_name('invalid')
  #   assert_nil merchant
  # end
  #
  # def test_merchant_find_by_name_is_case_insensitive
  #   merchant = @merchant_repository.find_by_name('candisart')
  #   assert_equal 'Candisart', merchant.name
  # end
  #
  # def test_find_all_by_name_or_name_fragment
  #   invoices_1 = @merchant_repository.find_all_by_name('Bike')
  #   invoices_2 = @merchant_repository.find_all_by_name('zzzz')
  #   invoices_3 = @merchant_repository.find_all_by_name('in')
  #   assert_equal 'MiniatureBikez', invoices_1.first.name
  #   assert_equal ([]), invoices_2
  #   assert_equal 'Shopin1901', invoices_3.first.name
  #   assert_equal 'MiniatureBikez', invoices_3[-1].name
  # end
  #
  # def test_it_can_find_highest_id
  #   merchant = @merchant_repository.find_highest_id
  #   assert_equal 12334113, merchant.id
  # end
  #
  # def test_it_can_create_new_id
  #   merchant = @merchant_repository.create_id
  #   assert_equal 12334114, merchant
  # end
  #
  # def test_it_can_create_new_merchant
  #   attributes = {  name: 'Turing School',
  #                   created_at: '2010-12-10',
  #                   updated_at: '2011-12-04'
  #                 }
  #   merchant = @merchant_repository.create(attributes)
  #   assert_equal 'Turing School', merchant.name
  #   assert_equal 12334114, merchant.id
  # end
  #
  # def test_it_can_update_merchant_name
  #   attributes = {
  #     name: 'Shopin2001'
  #   }
  #   id = 12334105
  #   merchant = @merchant_repository.update(id, attributes)
  #   expected = @merchant_repository.find_by_id(id)
  #   assert_equal 'Shopin2001', expected.name
  #   expected = @merchant_repository.find_by_name('Shopin1901')
  #   assert_nil expected
  # end
  #
  # def test_it_can_delete_merchant
  #   id = 12334105
  #
  #   merchant = @merchant_repository.delete(id)
  #   expected_1 = @merchant_repository.find_by_name('Shopin1901')
  #   expected_2 = @merchant_repository.find_by_id(id)
  #
  #   assert_nil expected_1
  #   assert_nil expected_2
  # end
end
