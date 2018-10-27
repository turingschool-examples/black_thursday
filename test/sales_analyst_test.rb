require './test/test_helper'
require './lib/sales_engine'
require './lib/item'
require './lib/item_repository'

class SalesAnalystTest < Minitest::Test
  def setup
    @item_1 = Item.new({
          :id          => 1,
          :name        => "Pencil",
          :description => "You can use it to pencil things",
          :unit_price  => (BigDecimal.new(3000,4) / 100),
          :created_at  => "2016-01-11 12:29:33 UTC",
          :updated_at  => "1993-08-29 22:53:20 UTC",
          :merchant_id => 1
        })
    @item_2 = Item.new({
          :id          => 2,
          :name        => "Marker",
          :description => "You can use it to mark things",
          :unit_price  => (BigDecimal.new(4000,4) / 100),
          :created_at  => "2016-01-11 12:02:55 UTC",
          :updated_at  => "1973-05-29 23:44:48 UTC",
          :merchant_id => 1
        })
    @item_3 = Item.new({
          :id          => 3,
          :name        => "Jump rope",
          :description => "Jump it",
          :unit_price  => (BigDecimal.new(20000,4) / 100),
          :created_at  => "2016-01-11 12:02:55 UTC",
          :updated_at  => "1973-05-29 23:44:48 UTC",
          :merchant_id => 1
        })
    @item_4 = Item.new({
          :id          => 4,
          :name        => "Elf costume",
          :description => "Be santa's little helper.",
          :unit_price  => (BigDecimal.new(5000,4) / 100),
          :created_at  => "2016-01-11 12:05:55 UTC",
          :updated_at  => "1973-05-29 23:44:48 UTC",
          :merchant_id => 2
        })
    @item_5 = Item.new({
          :id          => 5,
          :name        => "Santa costume",
          :description => "Be santa.",
          :unit_price  => (BigDecimal.new(6000,4) / 100),
          :created_at  => "2016-01-11 12:05:55 UTC",
          :updated_at  => "1973-05-29 23:44:48 UTC",
          :merchant_id => 2
        })
    @item_6 = Item.new({
          :id          => 6,
          :name        => "Devil costume",
          :description => "Be santa's enemy.",
          :unit_price  => (BigDecimal.new(4000,4) / 100),
          :created_at  => "2016-01-11 12:05:55 UTC",
          :updated_at  => "1973-05-29 23:44:48 UTC",
          :merchant_id => 3
        })
    @item_7 = Item.new({
          :id          => 7,
          :name        => "Easter Bunny costume",
          :description => "Be santa's rival.",
          :unit_price  => (BigDecimal.new(5000,4) / 100),
          :created_at  => "2016-01-11 12:05:55 UTC",
          :updated_at  => "1973-05-29 23:44:48 UTC",
          :merchant_id => 3
        })
    @ir = ItemRepository.new
    @ir.add_item(@item_1)
    @ir.add_item(@item_2)
    @ir.add_item(@item_3)
    @ir.add_item(@item_4)
    @ir.add_item(@item_5)
    @ir.add_item(@item_6)
    @ir.add_item(@item_7)

    @mr = MerchantRepository.new
    @merchant_1 = Merchant.new({:id => 1, :name => "Keckenbauer"})
    @merchant_2 = Merchant.new({:id => 2, :name => "BowlsByChris"})
    @merchant_3 = Merchant.new({:id => 3, :name => "SassyStrangeArt"})
    @mr.add_merchant(@merchant_1)
    @mr.add_merchant(@merchant_2)
    @mr.add_merchant(@merchant_3)

    @invoice_1 = Invoice.new({
      :id          => 1,
      :customer_id => 100,
      :merchant_id => 1,
      :status      => :pending,
      :created_at  => Time.now,
      :updated_at  => Time.now,
      })
    @invoice_2 = Invoice.new({
      :id          => 2,
      :customer_id => 101,
      :merchant_id => 2,
      :status      => :shipped,
      :created_at  => Time.now,
      :updated_at  => Time.now,
      })
    @invoice_3 = Invoice.new({
      :id          => 3,
      :customer_id => 102,
      :merchant_id => 2,
      :status      => :pending,
      :created_at  => Time.now,
      :updated_at  => Time.now,
      })
    @inr = InvoiceRepository.new
    @inr.add_invoice(@invoice_1)
    @inr.add_invoice(@invoice_2)
    @inr.add_invoice(@invoice_3)

    #add transactions next after the classes are made for transaction and repository
    # @transaction_1 = ...
    # @tr = TransactionRepository.new

    @se = SalesEngine.new({merchants: @mr, items: @ir, invoices: @inr, transactions: @tr})
    @sa = @se.analyst

    ############ REMOVE AT SOME POINT ##############
    # @se_real = SalesEngine.from_csv({
    #   :items     => "./data/items.csv",
    #   :merchants => "./data/merchants.csv",
    #   :invoices => "./data/invoices.csv",
    #   :transactions => "./data/transactions.csv"
    # })
    # @sa_real = @se_real.analyst
    ################################################
  end

  def test_average_items_per_merchant
    assert_equal 2.33 , @sa.average_items_per_merchant
  end

  def test_it_can_find_average_price_of_items
    assert_equal 67.14, @sa.average_price_of_items
  end

  def test_it_can_find_golden_items
    assert_equal [@item_3], @sa.golden_items
  end

  def test_merchants_with_high_item_count
    assert_equal [@merchant_1], @sa.merchants_with_high_item_count
  end

  def test_avg_avg_per_merchant
    assert_equal 63.33, @sa.average_average_price_per_merchant
    assert_instance_of BigDecimal, @sa.average_average_price_per_merchant
  end

  def test_average_item_price_for_merchant
    assert_instance_of BigDecimal, @sa.average_item_price_for_merchant(1)
    assert_equal 90, @sa.average_item_price_for_merchant(1)
  end

  def test_it_can_find_average_items_per_merchant_std_dev
    assert_equal 0.58, @sa.average_items_per_merchant_standard_deviation
    assert_instance_of Float, @sa.average_items_per_merchant_standard_deviation
  end

  ########### FROM REAL DATA, UPDATE TO FAKE DATA ##########
  def test_it_can_find_average_invoices_per_merchant
    # assert_equal 10.49, @sa_real.average_invoices_per_merchant
    assert_equal 1.5, @sa.average_invoices_per_merchant
    assert_instance_of Float, @sa.average_invoices_per_merchant
  end

  def test_it_can_find_average_invoices_per_merchant_std_dev
    # assert_equal 3.29, @sa_real.average_invoices_per_merchant_standard_deviation
    assert_equal 0.71, @sa.average_invoices_per_merchant_standard_deviation
    assert_instance_of Float, @sa.average_invoices_per_merchant_standard_deviation
  end

  def test_it_can_find_top_merchants_by_invoice_count_2_std_dev_above_mean
    # merchant_count = @sa_real.top_merchants_by_invoice_count.count
    # assert_equal 12, merchant_count
    merchant_count = @sa.top_merchants_by_invoice_count.count
    assert_equal 0, merchant_count
  end

  def test_it_can_find_bottom_merchants_by_invoice_count_2_std_dev_bel_mean
    # merchant_count = @sa_real.bottom_merchants_by_invoice_count.count
    # assert_equal 4, merchant_count
    merchant_count = @sa.bottom_merchants_by_invoice_count.count
    assert_equal 0, merchant_count
  end

  def test_it_can_find_top_days_by_invoice_count_1_std_dev_above_mean
    # assert_equal ["Wednesday"], @sa_real.top_days_by_invoice_count
    assert_equal [], @sa.top_days_by_invoice_count
  end

  def test_it_can_find_percentages_of_orders_shipped_pending_and_returned
    # assert_equal 29.55, @sa_real.invoice_status(:pending)
    # assert_equal 56.95, @sa_real.invoice_status(:shipped)
    # assert_equal 13.5, @sa_real.invoice_status(:returned)
    assert_equal 66.67, @sa.invoice_status(:pending)
    assert_equal 33.33, @sa.invoice_status(:shipped)
    assert_equal 0.0, @sa.invoice_status(:returned)
  end
end
