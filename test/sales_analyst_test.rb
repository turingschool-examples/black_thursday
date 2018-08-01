require_relative 'test_helper'
require_relative '../lib/sales_analyst.rb'
require_relative '../lib/sales_engine.rb'

class SalesAnalystTest < Minitest::Test
  def setup
    @item_1 = Item.new({
      :id => 263395237,
      :name => "Pencil",
      :description => "You can use it to write things",
      :unit_price  => 1099,
      :merchant_id => "12334141",
      :created_at  => "1972-07-30 18:08:53 UTC",
      :updated_at  => "1972-07-30 18:08:53 UTC"
      })
    @item_2 = Item.new({
      :id => 263395985,
      :name => "Marker",
      :description => "You can use it to write more things",
      :unit_price  => 1299,
      :merchant_id => "12339191",
      :created_at  => "1972-07-30 18:08:53 UTC",
      :updated_at  => "1972-07-30 18:08:53 UTC"
      })
    @item_3 = Item.new({
      :id => 7,
      :name => "Chapstick",
      :description => "Moisturizes lips.",
      :unit_price  => 455,
      :merchant_id => "12337777",
      :created_at  => "1972-07-30 18:08:53 UTC",
      :updated_at  => "1972-07-30 18:08:53 UTC"
      })
    @item_4 = Item.new({
      :id => 263395239,
      :name => "Water Bottle",
      :description => "Used for drinking water",
      :unit_price  => 1850,
      :merchant_id => "12337777",
      :created_at  => "1972-07-30 18:08:53 UTC",
      :updated_at  => "1972-07-30 18:08:53 UTC"
      })
    @item_5 = Item.new({
      :id => 263395240,
      :name => "Cool Stuff",
      :description => "Use when you want to be cool",
      :unit_price  => 21050,
      :merchant_id => "12337777",
      :created_at  => "1972-07-30 18:08:53 UTC",
      :updated_at  => "1972-07-30 18:08:53 UTC"
      })

    @merchant_1 = Merchant.new({
      :id => "12334141",
      :name => "Target",
      :created_at => "1972-07-30 18:08:53 UTC",
      :updated_at => "1972-07-30 18:08:53 UTC"
      })
    @merchant_2 = Merchant.new({
      :id => "12337777",
      :name => "Walmart",
      :created_at => "1972-07-30 18:08:53 UTC",
      :updated_at => "1972-07-30 18:08:53 UTC"
      })
    @merchant_3 = Merchant.new({
      :id => "12339191",
      :name => "Cool Place",
      :created_at => "1972-07-30 18:08:53 UTC",
      :updated_at => "1972-07-30 18:08:53 UTC"
      })

    @invoice_1 = Invoice.new({
      :id => 6,
      :customer_id => 26,
      :merchant_id => 12334141,
      :status => "pending",
      :created_at => "2009-02-07",
      :updated_at => "2009-02-08"
      })
    @invoice_2 = Invoice.new({
      :id => 7,
      :customer_id => 37,
      :merchant_id => 12337777,
      :status => "pending",
      :created_at => "2009-02-07",
      :updated_at => "2009-02-10"
      })
    @invoice_3 = Invoice.new({
      :id => 8,
      :customer_id => 48,
      :merchant_id => 12339191,
      :status => "shipped",
      :created_at => "2009-02-11",
      :updated_at => "2009-02-12"
      })
    @invoice_4 = Invoice.new({
      :id => 9,
      :customer_id => 48,
      :merchant_id => 12339191,
      :status => "returned",
      :created_at => "2009-02-13",
      :updated_at => "2009-02-14"
      })

    @invoice_item_1 = InvoiceItem.new({
      :id => 6,
      :item_id => 7,
      :invoice_id => 6,
      :quantity => 1,
      :unit_price => 10099,
      :created_at => "1972-07-30 18:08:53 UTC",
      :updated_at => "1972-07-30 18:08:53 UTC"
      })
    @invoice_item_2 = InvoiceItem.new({
      :id => 7,
      :item_id => 33,
      :invoice_id => 6,
      :quantity => 1,
      :unit_price => 599,
      :created_at => "1972-07-30 18:08:53 UTC",
      :updated_at => "1972-07-30 18:08:53 UTC"
      })
    @invoice_item_3 = InvoiceItem.new({
      :id => 8,
      :item_id => 7,
      :invoice_id => 7,
      :quantity => 1,
      :unit_price => 1236,
      :created_at => "1972-07-30 18:08:53 UTC",
      :updated_at => "1972-07-30 18:08:53 UTC"
      })
    @invoice_item_4 = InvoiceItem.new({
      :id => 9,
      :item_id => 987,
      :invoice_id => 8,
      :quantity => 1,
      :unit_price => 979,
      :created_at => "1972-07-30 18:08:53 UTC",
      :updated_at => "1972-07-30 18:08:53 UTC"
      })

    @customer_1 = Customer.new({
      :id => 6,
      :first_name => "Joan",
      :last_name => "Clarke",
      :created_at => "1972-07-30 18:08:53 UTC",
      :updated_at => "1972-07-30 18:08:53 UTC"
      })
    @customer_2 = Customer.new({
      :id => 33,
      :first_name => "Kat",
      :last_name => "Clarkson",
      :created_at => "1972-07-30 18:08:53 UTC",
      :updated_at => "1972-07-30 18:08:53 UTC"
      })
    @customer_3 = Customer.new({
      :id => 12,
      :first_name => "Nick",
      :last_name => "Program",
      :created_at => "1972-07-30 18:08:53 UTC",
      :updated_at => "1972-07-30 18:08:53 UTC"
      })
    @customer_4 = Customer.new({
      :id => 90,
      :first_name => "Nicolas",
      :last_name => "Jones",
      :created_at => "1972-07-30 18:08:53 UTC",
      :updated_at => "1972-07-30 18:08:53 UTC"
      })

    @transaction_1 = Transaction.new({
      :id => 6,
      :invoice_id => 6,
      :credit_card_number => "4242424242421111",
      :credit_card_expiration_date => "0220",
      :result => "failed",
      :created_at => "1972-07-30 18:08:53 UTC",
      :updated_at => "1972-07-30 18:08:53 UTC"
      })
    @transaction_2 = Transaction.new({
      :id => 7,
      :invoice_id => 9,
      :credit_card_number => "4242424242422222",
      :credit_card_expiration_date => "0321",
      :result => "success",
      :created_at => "1972-07-30 18:08:53 UTC",
      :updated_at => "1972-07-30 18:08:53 UTC"
      })
    @transaction_3 = Transaction.new({
      :id => 8,
      :invoice_id => 7,
      :credit_card_number => "4242424242423333",
      :credit_card_expiration_date => "0422",
      :result => "success",
      :created_at => "1972-07-30 18:08:53 UTC",
      :updated_at => "1972-07-30 18:08:53 UTC"
      })
    @transaction_4 = Transaction.new({
      :id => 9,
      :invoice_id => 11,
      :credit_card_number => "4242424242424444",
      :credit_card_expiration_date => "0523",
      :result => "success",
      :created_at => "1972-07-30 18:08:53 UTC",
      :updated_at => "1972-07-30 18:08:53 UTC"
      })

    @items = [@item_1, @item_2, @item_3, @item_4, @item_5]
    @merchants = [@merchant_1, @merchant_2, @merchant_3]
    @invoices = [@invoice_1, @invoice_2, @invoice_3, @invoice_4]
    @invoice_items = [@invoice_item_1, @invoice_item_2, @invoice_item_3, @invoice_item_4]
    @customers = [@customer_1, @customer_2, @customer_3, @customer_4]
    @transactions = [@transaction_1, @transaction_2, @transaction_3, @transaction_4]

    @sales_engine = SalesEngine.new(@merchants, @items, @invoices, @invoice_items, @transactions, @customers)
    @sales_analyst = @sales_engine.analyst
  end

  def test_it_exists
    assert_instance_of SalesAnalyst, @sales_analyst
  end

  def test_it_can_average_items_per_merchant
    expected = 1.67
    actual = @sales_analyst.average_items_per_merchant

    assert_equal expected, actual
  end

  def test_it_can_find_stddev_of_average_items_per_merchant
    expected = 0.94
    actual = @sales_analyst.average_items_per_merchant_standard_deviation

    assert_equal expected, actual
  end

  def test_which_merchants_exceed_1_stdev_higher_than_average_number_products
    expected = 1
    actual = @sales_analyst.merchants_with_high_item_count.count

    assert_equal expected, actual
  end

  def test_it_can_find_average_item_price_for_merchant
    expected = 77.85.to_d
    actual = @sales_analyst.average_item_price_for_merchant(12337777)

    assert_equal expected, actual
  end

  def test_it_can_find_average_average_price_for_merchant
    expected = 33.94
    actual = @sales_analyst.average_average_price_per_merchant

    assert_equal expected, actual
  end

  def test_it_can_find_golden_items
    item_6 = Item.new({
      :id => 263395241,
      :name => "Really Cool Stuff",
      :description => "Use when you want to be ultimately cool",
      :unit_price  => 9050,
      :merchant_id => "12337777",
      :created_at  => "1972-07-30 18:08:53 UTC",
      :updated_at  => "1972-07-30 18:08:53 UTC"
      })
      @items << item_6

    expected = 1
    actual = @sales_analyst.golden_items.count

    assert_equal expected, actual
  end

  def test_it_can_find_average_invoices_per_merchant
    expected = 1.33
    actual = @sales_analyst.average_invoices_per_merchant

    assert_equal expected, actual
  end

  def test_it_can_find_stddev_of_average_invoices_per_merchant
    expected = 0.47
    actual = @sales_analyst.average_invoices_per_merchant_standard_deviation

    assert_equal expected, actual
  end

  def test_it_can_find_top_merchants_by_invoice_count
    @sales_engine = SalesEngine.from_csv({
     items: "./data/items.csv",
     merchants: "./data/merchants.csv",
     invoices: "./data/invoices.csv",
     invoice_items: "./data/invoice_items.csv",
     transactions: "./data/transactions.csv",
     customers: "./data/customers.csv"
     })
   @sales_analyst = @sales_engine.analyst

    expected = 12
    actual = @sales_analyst.top_merchants_by_invoice_count

    assert_instance_of Merchant, actual[0]
    assert_equal expected, actual.count
  end

  def test_it_can_find_bottom_merchants_by_invoice_count
    @sales_engine = SalesEngine.from_csv({
         items: "./data/items.csv",
         merchants: "./data/merchants.csv",
         invoices: "./data/invoices.csv",
         invoice_items: "./data/invoice_items.csv",
         transactions: "./data/transactions.csv",
         customers: "./data/customers.csv"
         })
       @sales_analyst = @sales_engine.analyst
    expected = 4
    actual = @sales_analyst.bottom_merchants_by_invoice_count

    assert_instance_of Merchant, actual[0]
    assert_equal expected, actual.count
  end

  def test_it_can_find_top_days_by_invoice_count

    expected = ["Saturday"]
    actual = @sales_analyst.top_days_by_invoice_count
    assert_equal expected, actual
  end

  def test_it_can_show_invoice_status_percentage
    expected = 50.0
    actual = @sales_analyst.invoice_status(:pending)

    assert_equal expected, actual

    expected_2 = 25.0
    actual_2 = @sales_analyst.invoice_status(:shipped)

    assert_equal expected_2, actual_2

    expected_3 = 25.0
    actual_3 = @sales_analyst.invoice_status(:returned)

    assert_equal expected_3, actual_3
  end

  def test_it_checks_if_invoice_paid_in_full
    refute @sales_analyst.invoice_paid_in_full?(6)
    assert @sales_analyst.invoice_paid_in_full?(7)
    assert @sales_analyst.invoice_paid_in_full?(9)
  end

  def test_it_can_return_invoice_total
    assert_equal 12.36, @sales_analyst.invoice_total(7)
  end

  def test_it_can_check_total_revenue_by_date
    assert_equal 119.34, @sales_analyst.total_revenue_by_date(Time.parse("2009-02-07"))
  end

  def test_it_can_check_revenue_by_merchant
    assert_equal 12.36, @sales_analyst.revenue_by_merchant(12337777)
  end

  def test_it_can_check_top_revenue_earners_with_argument
    top_revenue_merchants = @sales_analyst.top_revenue_earners(3)
    assert_equal 3, @sales_analyst.top_revenue_earners(3).count
    assert_instance_of Merchant, top_revenue_merchants[0]
    assert_equal 12337777, @sales_analyst.top_revenue_earners(3).first.id
    assert_equal 12334141, @sales_analyst.top_revenue_earners(3).last.id

    assert_equal 3, @sales_analyst.top_revenue_earners.count
    assert_equal 12337777, @sales_analyst.top_revenue_earners.first.id
    assert_equal 12334141, @sales_analyst.top_revenue_earners.last.id
  end

  def test_it_can_rank_all_revenue_earners
    ranked_revenue_merchants = @sales_analyst.merchants_ranked_by_revenue
    assert_equal 3, @sales_analyst.merchants_ranked_by_revenue.count
    assert_equal 12337777, @sales_analyst.merchants_ranked_by_revenue.first.id
    assert_equal 12334141, @sales_analyst.merchants_ranked_by_revenue.last.id
    assert_instance_of Merchant, ranked_revenue_merchants[0]
  end

  def test_it_can_get_merchants_with_pending_invoices
    actual = @sales_analyst.merchants_with_pending_invoices
    assert_instance_of Merchant, actual[0]
    assert_equal 2, actual.count
  end

  def test_it_can_return_the_most_sold_item_for_merchant
    assert_instance_of Item, @sales_analyst.most_sold_item_for_merchant(12337777).first
  end

  def test_it_can_return_the_best_item_for_merchant
    assert_instance_of Item, @sales_analyst.best_item_for_merchant(12337777)
  end
end
