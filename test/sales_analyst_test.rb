require './test/test_helper'
require './lib/sales_engine'
require './lib/item'
require './lib/item_repository'
require './lib/transaction'
require './lib/transaction_repository'
require './lib/customer'
require './lib/customer_repository'

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

    @tran_1 = Transaction.new({:id => 12,
      :invoice_id => 2,
      :credit_card_number => 4068631943231473,
      :credit_card_expiration => 0217,
      :result => :success,
      :created_at => Time.now,
      :updated_at=> Time.now})

    @tran_2 = Transaction.new({:id => 13,
      :invoice_id => 1,
      :credit_card_number => 4068631940004734,
      :credit_card_expiration => 0217,
      :result => :failed,
      :created_at => Time.now,
      :updated_at=> Time.now})

    @tran_3 = Transaction.new({:id => 14,
      :invoice_id => 3,
      :credit_card_number => 4068631943231473,
      :credit_card_expiration => 0217,
      :result => :success,
      :created_at => Time.now,
      :updated_at=> Time.now})
    @tr = TransactionRepository.new
    @tr.add_transaction(@tran_1)
    @tr.add_transaction(@tran_2)
    @tr.add_transaction(@tran_3)
    @invoice_item_1 = Item.new({
          :id          => 2,
          :invoice_id  => 1,
          :item_id     => 3,
          :unit_price  => (BigDecimal.new(23324,4) / 100),
          :created_at  => Time.parse("2012-03-27 14:54:09 UTC"),
          :updated_at  => Time.parse("2012-03-27 14:54:09 UTC"),
          :quantity    => 9
        })
    @invoice_item_2 = Item.new({
          :id          => 4,
          :invoice_id  => 2,
          :item_id     => 2,
          :unit_price  => (BigDecimal.new(2196,4) / 100),
          :created_at  => Time.parse("2012-03-27 14:54:09 UTC"),
          :updated_at  => Time.parse("2012-03-27 14:54:09 UTC"),
          :quantity    => 3
        })
    @invoice_item_3 = Item.new({
          :id          => 6,
          :invoice_id  => 3,
          :item_id     => 1,
          :unit_price  => (BigDecimal.new(52100,4) / 100),
          :created_at  => Time.parse("2012-03-27 14:54:09 UTC"),
          :updated_at  => Time.parse("2012-03-27 14:54:09 UTC"),
          :quantity    => 5
        })
    @invoice_item_4 = Item.new({
          :id          => 8,
          :invoice_id  => 1,
          :item_id     => 3,
          :unit_price  => (BigDecimal.new(5000,4) / 100),
          :created_at  => Time.parse("2012-03-27 14:54:09 UTC"),
          :updated_at  => Time.parse("2012-03-27 14:54:09 UTC"),
          :quantity    => 6
        })
    @ii = InvoiceItemRepository.new
    @ii.add_invoice_item(@invoice_item_1)
    @ii.add_invoice_item(@invoice_item_2)
    @ii.add_invoice_item(@invoice_item_3)
    @ii.add_invoice_item(@invoice_item_4)
    @customer_1 = Customer.new({id: 100, first_name: "J", last_name: "C",
                  created_at: Time.now, updated_at: Time.now})
    @customer_2 = Customer.new({id: 101, first_name: "C", last_name: "J",
                  created_at: Time.now, updated_at: Time.now})
    @customer_3 = Customer.new({id: 102, first_name: "JC", last_name: "CJ",
                  created_at: Time.now, updated_at: Time.now})
    @cr = CustomerRepository.new
    @cr.add_customer(@customer_1)
    @cr.add_customer(@customer_2)
    @cr.add_customer(@customer_3)
    @se = SalesEngine.new({merchants: @mr, items: @ir, invoices: @inr,
                transactions: @tr, invoice_items: @ii, customers: @cr})
    @sa = @se.analyst
    
    ############ REMOVE AT SOME POINT TO IMPROVE RUN SPEED ##############
    @se_real = SalesEngine.from_csv({
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv",
      :invoices => "./data/invoices.csv",
      :transactions => "./data/transactions.csv",
      :invoice_items => "./data/invoice_items.csv",
      :customers => "./data/customers.csv"
    })
    @sa_real = @se_real.analyst
    ######################################################################
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

  def test_it_can_check_if_invoice_is_paid_in_full
    assert_equal true, @sa_real.invoice_paid_in_full?(1)
    assert_equal false, @sa_real.invoice_paid_in_full?(204)
  end

  def test_it_can_get_total_revenue_by_date
    date = Time.parse("2009-02-07")
    actual = @sa_real.total_revenue_by_date(date) #=> $$
    assert_equal 21067.77, actual
    assert_instance_of BigDecimal, actual
  end

  def test_top_revenue_earners
    x = 10
    actual = @sa_real.top_revenue_earners(x)
    assert_equal 12334634, actual.first.id
    assert_equal 12335747, actual.last.id
    assert_equal 10, actual.length
    assert_instance_of Merchant, actual.first
  end

  def test_top_revenue_earners_default
    actual = @sa_real.top_revenue_earners
    assert_equal 12334634, actual.first.id
    assert_equal 12334159, actual.last.id
    assert_equal 20, actual.length
    assert_instance_of Merchant, actual.first
  end

  def test_it_can_rank_merchants_by_revenue
    actual = @sa_real.merchants_ranked_by_revenue
    assert_instance_of Merchant, actual.first
    assert_equal 12334634, actual.first.id
    assert_equal 12336175, actual.last.id
  end

  def test_it_can_find_merchants_pending_invoices
    actual = @sa_real.merchants_with_pending_invoices
    assert_instance_of Merchant, actual.first
    assert_equal 467, actual.length
  end

  def test_it_can_return_merchants_with_one_item
    actual = @sa_real.merchants_with_only_one_item
    assert_equal 243, actual.length
    assert_instance_of Merchant, actual.first
  end

  def test_it_can_find_merchants_with_only_one_item_registered_in_month
    actual = @sa_real.merchants_with_only_one_item_registered_in_month("March")
    assert_equal 21, actual.length
    assert_instance_of Merchant, actual.first
  end

  def test_it_can_find_revenue_by_merchant
    actual = @sa_real.revenue_by_merchant(12334194)
    assert_equal BigDecimal.new(81572.4, 6), actual
    assert_instance_of BigDecimal, actual
  end

  def test_it_can_find_most_sold_item_for_merchant
    actual = @sa_real.most_sold_item_for_merchant(12334189)
    assert_equal true, actual.map(&:name).include?("Adult Princess Leia Hat")

    merchant_id = 12337105
    actual = @sa_real.most_sold_item_for_merchant(merchant_id)
    assert_equal 4, actual.length
  end

  def test_it_can_find_best_item_for_merchant
    actual = @sa_real.best_item_for_merchant(12334189)
    assert_equal 263516130, actual.id
    assert_instance_of Item, actual

    actual = @sa_real.best_item_for_merchant(12337105)
    assert_equal 263463003, actual.id
  end

  def test_it_can_find_one_time_buyers
    otb = @sa.one_time_buyers
    assert_equal 3, otb.length
    assert_instance_of Customer, otb.first
    assert_equal [@customer_1, @customer_2, @customer_3], otb
  end

end
