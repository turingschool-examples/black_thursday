require 'csv'
require './test/test_helper'
require './lib/merchant'
require './lib/sales_engine'
require 'pry'
class MerchantTest < Minitest::Test
  def test_merchant_exists
    merchant = Merchant.new({
      id: 5,
      name: 'Turing School',
      created_at: 11/11/11,
      updated_at: 12/21/12,
    }, 'parent')

    assert_instance_of Merchant, merchant
  end

  def test_mechant_collects_id_and_name
    merchant = Merchant.new({
      id: 5,
      name: 'Turing School',
      created_at: 11/11/11,
      updated_at: 12/21/12,
    }, 'parent')

    assert_equal 5, merchant.id
    assert_equal 'Turing School', merchant.name
    assert_equal 11/11/11, merchant.created_at
    assert_equal 12/21/12, merchant.updated_at
  end

  def test_items_method
    skip
    se = SalesEngine.from_csv(items: './test/fixtures/items.csv',
                              merchants: './test/fixtures/merchants.csv')
    parent = MerchantRepository.new('./test/fixtures/merchants.csv',
                                    se)
    merchant = Merchant.new({ id: '2', name: '' }, parent)

    assert_instance_of Array, merchant.items
    assert_instance_of Item, merchant.items[0]
    assert_equal 3, merchant.items.length
  end

  def test_invoices_method
    skip
    se = SalesEngine.from_csv(items: './test/fixtures/items_truncated.csv',
                              merchants: './test/fixtures/merchants_truncated.csv',
                              invoices: './test/fixtures/invoices_truncated.csv')
    parent = MerchantRepository.new('./test/fixtures/merchants.csv',
                                    se)
    merchant = Merchant.new({ id: '2', name: '' }, parent)

    assert_instance_of Array, merchant.invoices
    assert_instance_of Invoice, merchant.invoices[0]
    assert_equal 4, merchant.invoices.length
  end
end
