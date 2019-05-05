# frozen_string_literal: true

require 'simplecov'
SimpleCov.start
require 'minitest'
require 'minitest/emoji'
require 'minitest/autorun'
require './lib/customer_repository.rb'
require './lib/sales_engine.rb'

# Tests the functionality of the customer repository.
class InvoiceRepositoryTest < MiniTest::Test
  def setup
    se = SalesEngine.from_csv({:invoices => './fixtures/invoices_test.csv',
                               :merchants => './fixtures/merchants_test.csv',
                               :items => './fixtures/items_test.csv',
                               :customers => './fixtures/customers_test.csv',
                               :transactions => './fixtures/transactions_test.csv'
      })
    @i = se.invoices
  end

  def test_it_exists
    assert_instance_of InvoiceRepository, @i
  end

  def test_it_finds_by_id
    expected = 1
    actual = @i.find_by_id(1).invoice_specs[:customer_id]

    assert_equal expected, actual
  end

  def test_it_finds_all_by_customer_id
    expected = :shipped
    actual = @i.find_all_by_customer_id(1).last.status

    assert_equal expected, actual
  end

  def test_it_finds_all_by_status
    expected = 7
    actual = @i.find_all_by_status(:pending).last.id

    assert_equal expected, actual
  end

  def test_it_finds_all_by_merchant_id
    expected = 1
    actual = @i.find_all_by_merchant_id(12334389).first.customer_id

    assert_equal expected, actual
  end

  def test_it_can_create_a_new_invoice
    expected = 10
    @i.create(merchant_id: 15, customer_id: 22, created_at: Time.now, updated_at: Time.now)
    actual = @i.find_by_id(10).id

    assert_equal expected, actual
  end

  def test_it_can_delete_an_invoice
    @i.delete(1)

    assert_nil @i.find_by_id(1)
  end

  def test_it_can_update_an_invoice
    expected = :shipped
    @i.update(1, status: 'shipped')
    actual = @i.find_by_id(1).status

    assert_equal expected, actual
  end

  def test_it_can_find_merchant_by_merchant_id
    expected = 'Shopin1901'
    actual = @i.find_merchant_by_merchant_id(12334105).name

    assert_equal expected, actual
  end

  def test_it_can_find_transaction_by_invoice_id
    expected = 'success'
    actual = @i.find_transaction_by_invoice_id(2179).first.result

    assert_equal expected, actual
  end

  def test_it_can_find_all_items_by_merchant_id
    expected = 263399037
    actual = @i.find_all_items_by_merchant_id(12334365).first.id

    assert_equal expected, actual
  end

  def test_it_can_find_customer_by_customer_id
    expected = 'Joey'
    actual = @i.find_customer_by_customer_id(1).first_name

    assert_equal expected, actual
  end
end
