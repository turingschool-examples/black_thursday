require './test/test_helper'
require './lib/sales_engine'
require './lib/item_repository'
require './lib/merchant_repository'
require './lib/merchant'
require './lib/item'
require './lib/invoice_items_repository'
require './lib/invoice_items'

class SalesEngineTest < Minitest::Test
  def setup
    @se = SalesEngine.from_csv({
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv",
      :invoices => "./data/invoices.csv",
      :invoice_items => "./data/invoice_items.csv",
      :transactions => "./data/transactions.csv"
    })
    binding.pry
  end

  def test_it_exists
    assert_instance_of SalesEngine, @se
  end

  def test_it_can_load_csv_files
    assert_instance_of MerchantRepository, @se.merchants
    assert_instance_of ItemRepository, @se.items
    assert_instance_of InvoiceRepository, @se.invoices
    assert_instance_of TransactionRepository, @se.transactions
  end

  def test_it_can_load_files_correctly
    merchant_2 = Merchant.new({id: 12334112, name: "Candisart"})
    assert_equal merchant_2.id, @se.merchants.all[1].id
    assert_equal merchant_2.name, @se.merchants.all[1].name
    item_2 = Item.new({
          :id          => 263395617,
          :name        => "Glitter scrabble frames",
          :description => "Glitter scrabble frames...",
          :unit_price  => (BigDecimal.new(1300,4) / 100),
          :created_at  => Time.parse("2016-1-11 11:51:37 UTC"),
          :updated_at  => Time.parse("1993-9-29 11:56:40 UTC"),
          :merchant_id => 12334185
        })
    assert_equal item_2.created_at, @se.items.all[1].created_at
    assert_equal item_2.updated_at, @se.items.all[1].updated_at
    assert_equal item_2.merchant_id, @se.items.all[1].merchant_id
    invoice_2 = Invoice.new({
      :id          => 2,
      :customer_id => 1,
      :merchant_id => 12334753,
      :status      => :shipped,
      :created_at  => Time.parse("2012-11-23"),
      :updated_at  => Time.parse("2013-04-14"),
      })
    assert_equal invoice_2.merchant_id, @se.invoices.all[1].merchant_id
    assert_equal invoice_2.status, @se.invoices.all[1].status
    assert_equal invoice_2.created_at, @se.invoices.all[1].created_at
  end

  def test_it_can_create_analyst
    sa = @se.analyst
    assert_instance_of SalesAnalyst, sa
  end

end
