require_relative 'test_helper'
require_relative '../lib/sales_engine'

class SalesEngineTest < Minitest::Test
  include DataParser

  def test_sales_engine_knows_about_merchant_repo
    se = SalesEngine.from_csv({
      :items         => "./data/items.csv",
      :merchants     => "./data/merchants.csv",
      :invoices      => "./data/invoices.csv",
      :invoice_items => "./data/invoice_items.csv"
      })
      assert_instance_of Merchant, se.merchants.all.first
      assert_equal 475, se.merchants.all.count
      assert_instance_of Merchant, se.merchants.all.last
    end

  def test_sales_engine_knows_about_item_repo
    se = SalesEngine.from_csv({
      :items         => "./data/items.csv",
      :merchants     => "./data/merchants.csv",
      :invoices      => "./data/invoices.csv",
      :invoice_items => "./data/invoice_items.csv"
      })
      assert_instance_of Item, se.items.all.first
      assert_equal 1367, se.items.all.count
      assert_instance_of Item, se.items.all.last
    end

    def test_sales_engine_knows_about_invoice_repo
      se = SalesEngine.from_csv({
        :items         => "./data/items.csv",
        :merchants     => "./data/merchants.csv",
        :invoices      => "./data/invoices.csv",
        :invoice_items => "./data/invoice_items.csv"
        })
        assert_instance_of Invoice, se.invoices.all.first
        assert_equal 4985, se.invoices.all.count 
        assert_instance_of Invoice, se.invoices.all.last
    end

    def test_sales_engine_knows_about_invoice_items_repo
      se = SalesEngine.from_csv({
        :items         => "./data/items.csv",
        :merchants     => "./data/merchants.csv",
        :invoices      => "./data/invoices.csv",
        :invoice_items => "./data/invoice_items.csv"
        })
        assert_instance_of InvoiceItem, se.invoice_items.all.first
        assert_equal 21830, se.invoice_items.all.count
        assert_instance_of InvoiceItem, se.invoice_items.all.last
    end

  def test_sales_engine_knows_about_find_by_name_in_merchant_repo
    se = SalesEngine.from_csv({
      :items         => "./data/items.csv",
      :merchants     => "./data/merchants.csv",
      :invoices      => "./data/invoices.csv",
      :invoice_items => "./data/invoice_items.csv"
      })
      merchant = se.merchants.find_by_name("Shopin1901")
      assert_equal "Shopin1901", merchant.name
    end

  def test_sales_engine_knows_about_find_by_name_in_item_repo
    se = SalesEngine.from_csv({
      :items         => "./data/items.csv",
      :merchants     => "./data/merchants.csv",
      :invoices      => "./data/invoices.csv",
      :invoice_items => "./data/invoice_items.csv"
      })
      item = se.items.find_by_name("Glitter scrabble frames")
      assert_equal "Glitter scrabble frames", item.name
    end

  def test_sale_engine_has_established_relationship_with_merchant_and_merchant_items
    se = SalesEngine.from_csv({
      :items         => "./data/items.csv",
      :merchants     => "./data/merchants.csv",
      :invoices      => "./data/invoices.csv",
      :invoice_items => "./data/invoice_items.csv"
      })
      merchant = se.merchants.find_by_id(12334105)
      assert_instance_of Item, merchant.items.first
      assert_equal 3, merchant.items.count
    end

  def test_sales_engine_has_relationship_with_merchant_from_item_id
    se = SalesEngine.from_csv({
      :items         => "./data/items.csv",
      :merchants     => "./data/merchants.csv",
      :invoices      => "./data/invoices.csv",
      :invoice_items => "./data/invoice_items.csv"
      })
      item = se.items.find_by_id(263395617)
      assert_instance_of Merchant, item.merchant
    end

  def test_sales_engine_has_relationship_with_invoices
    se = SalesEngine.from_csv({
      :items         => "./data/items.csv",
      :merchants     => "./data/merchants.csv",
      :invoices      => "./data/invoices.csv",
      :invoice_items => "./data/invoice_items.csv"
      })
      merchant = se.merchants.find_by_id(12334105)
      assert_equal 10, merchant.invoices.count
  end

  def test_sales_engine_has_relationship_with_merchant_from_invoice_id
    se = SalesEngine.from_csv({
      :items         => "./data/items.csv",
      :merchants     => "./data/merchants.csv",
      :invoices      => "./data/invoices.csv",
      :invoice_items => "./data/invoice_items.csv"
      })
      invoice = se.invoices.find_by_id(10)
      assert_instance_of Merchant, invoice.merchant
  end

  def test_sales_engine_has_relationship_with_invoice_items
    se = SalesEngine.from_csv({
      :items         => "./data/items.csv",
      :merchants     => "./data/merchants.csv",
      :invoices      => "./data/invoices.csv",
      :invoice_items => "./data/invoice_items.csv"
      })
      assert_instance_of InvoiceItem, se.invoice_items.find_by_id(6)
  end

  # def test_sales_engine_has_relationship_with_merchant_from_invoice_item_id
  #   se = SalesEngine.from_csv({
  #     :items         => "./data/items.csv",
  #     :merchants     => "./data/merchants.csv",
  #     :invoices      => "./data/invoices.csv",
  #     :invoice_items => "./data/invoice_items.csv"
  #     })
  #
  # end
end
