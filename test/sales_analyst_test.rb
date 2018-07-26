require_relative 'test_helper'
require_relative '../lib/sales_analyst'
require_relative '../lib/sales_engine'
require 'bigdecimal'
require 'pry'

class SalesAnalystTest < Minitest::Test

  def setup
    @item_1 = Item.new({:id => 263395237, :name => "Pencil", :description => "You can use it to write things", :unit_price  => BigDecimal.new(10.99,4), :merchant_id => 12334141, :created_at  => Time.now, :updated_at  => Time.now})
    @item_2 = Item.new({:id => 263395985,:name => "Marker",:description => "You can use it to write more things",:unit_price  => BigDecimal.new(12.99,4), :merchant_id => 12339191, :created_at  => Time.now,:updated_at  => Time.now})
    @item_3 = Item.new({:id => 263395234, :name => "Chapstick", :description => "Moisturizes lips.", :unit_price  => BigDecimal.new(4.55,4), :merchant_id => 12337777, :created_at  => Time.now, :updated_at  => Time.now})
    @item_4 = Item.new({:id => 263395239, :name => "Water Bottle", :description => "Used for drinking water", :unit_price  => BigDecimal.new(18.50,4), :merchant_id => 12337777, :created_at  => Time.now, :updated_at  => Time.now})
    @item_5 = Item.new({:id => 263395240, :name => "Cool Stuff", :description => "Use when you want to be cool", :unit_price  => BigDecimal.new(18.50,4), :merchant_id => 12337777, :created_at  => Time.now, :updated_at  => Time.now})

    @merchant_1 = Merchant.new({:id => 12334141, :name => "Target"})
    @merchant_2 = Merchant.new({:id => 12337777, :name => "Walmart"})
    @merchant_3 = Merchant.new({:id => 12339191, :name => "Cool Place"})

    @invoice_1 = Invoice.new({:id => 6, :customer_id => 26, :merchant_id => 12334141, :status => :pending, :created_at => "2009-02-07", :updated_at => Time.now})
    @invoice_2 = Invoice.new({:id => 7, :customer_id => 37, :merchant_id => 12337777, :status => :pending, :created_at => "2009-02-07", :updated_at => Time.now})
    @invoice_3 = Invoice.new({:id => 8, :customer_id => 48, :merchant_id => 12339191, :status => :pending, :created_at => "2009-02-07", :updated_at => Time.now})
    @invoice_4 = Invoice.new({:id => 9, :customer_id => 48, :merchant_id => 12339191, :status => :pending, :created_at => "2009-02-07", :updated_at => Time.now})

    @items = [@item_1, @item_2, @item_3, @item_4, @item_5]
    @merchants = [@merchant_1, @merchant_2, @merchant_3]
    @invoices = [@invoice_1, @invoice_2, @invoice_3, @invoice_4]

    @sales_engine = SalesEngine.new(@items, @merchants, @invoices)
    @sales_analyst = @sales_engine.analyst
  end

  def test_it_exists
    assert_instance_of SalesAnalyst, @sales_analyst
  end

  def test_it_has_attributes
    assert_equal @sales_engine.items, @sales_analyst.items
    assert_equal @sales_engine.merchants, @sales_analyst.merchants
  end

  def test_it_gives_average_items_per_merchant
    actual = @sales_analyst.average_items_per_merchant
    expected = 1.67

    assert_equal expected, actual
  end

  def test_it_calculates_standard_deviation
    actual = @sales_analyst.average_items_per_merchant_standard_deviation
    expected = 1.15

    assert_equal expected, actual
  end

  def test_find_merchants_with_high_item_count
    actual = @sales_analyst.merchants_with_high_item_count
    expected = [@merchant_2]

    assert_equal expected, actual
  end

  def test_it_calculates_average_price_for_specific_merchant
    actual = @sales_analyst.average_item_price_for_merchant(12337777)
    expected = 13.85

    assert_instance_of BigDecimal, actual
    assert_equal expected, actual

    actual = @sales_analyst.average_item_price_for_merchant(12334141)
    assert_equal 10.99, actual
  end

  def test_it_calculates_average_price_for_all_merchants
    actual = @sales_analyst.average_average_price_per_merchant
    expected = 12.61

    assert_equal expected, actual
  end

  def test_it_finds_item_price_average
    item_6 = Item.new({:id => 263395241, :name => "Really Cool Stuff", :description => "Use when you want to be ultimately cool", :unit_price  => BigDecimal.new(45.50,4), :merchant_id => 12337777, :created_at  => Time.now, :updated_at  => Time.now})
    @items << item_6

    expected = 18.51
    actual = @sales_analyst.average_of_item_prices

    assert_equal expected, actual
  end

  def test_it_finds_standard_deviation_of_prices
    item_6 = Item.new({:id => 263395241, :name => "Really Cool Stuff", :description => "Use when you want to be ultimately cool", :unit_price  => BigDecimal.new(45.50,4), :merchant_id => 12337777, :created_at  => Time.now, :updated_at  => Time.now})
    @items << item_6

    expected = 14.22
    actual = @sales_analyst.standard_deviation_of_prices

    assert_equal expected, actual
    assert_instance_of BigDecimal, actual
  end

  def test_it_finds_golden_items
    item_6 = Item.new({:id => 263395241, :name => "Really Cool Stuff", :description => "Use when you want to be ultimately cool", :unit_price  => BigDecimal.new(90.50,4), :merchant_id => 12337777, :created_at  => Time.now, :updated_at  => Time.now})
    @items << item_6

    expected = [item_6]
    actual = @sales_analyst.golden_items

    assert_equal expected, actual
  end

  def test_finds_average_invoices_per_merchant
    assert_equal 1.33, @sales_analyst.average_invoices_per_merchant
  end

  def test_it_finds_standard_deviation_of_invoices
    assert_equal 0.58 , @sales_analyst.average_invoices_per_merchant_standard_deviation
  end

  def test_it_can_find_number_of_invoices
    merchant_ids = @sales_analyst.find_all_merchant_ids
    assert_equal [1, 1, 2], @sales_analyst.get_number_of_invoices_from_merchants(merchant_ids)
  end

  def test_it_finds_top_performing_merchants
    invoice_5 = Invoice.new({:id => 10, :customer_id => 48, :merchant_id => 12339191, :status => "pending", :created_at => Time.now, :updated_at => Time.now})
    invoice_6 = Invoice.new({:id => 11, :customer_id => 48, :merchant_id => 12339191, :status => "pending", :created_at => Time.now, :updated_at => Time.now})
    invoice_7 = Invoice.new({:id => 12, :customer_id => 48, :merchant_id => 12339191, :status => "pending", :created_at => Time.now, :updated_at => Time.now})

    @invoices << invoice_5
    @invoices << invoice_6
    @invoices << invoice_7

    assert_equal [], @sales_analyst.top_merchants_by_invoice_count
  end

  def test_it_finds_bottom_performing_merchants
    invoice_5 = Invoice.new({:id => 10, :customer_id => 48, :merchant_id => 12339191, :status => "pending", :created_at => Time.now, :updated_at => Time.now})
    invoice_6 = Invoice.new({:id => 11, :customer_id => 48, :merchant_id => 12339191, :status => "pending", :created_at => Time.now, :updated_at => Time.now})
    invoice_7 = Invoice.new({:id => 12, :customer_id => 48, :merchant_id => 12339191, :status => "pending", :created_at => Time.now, :updated_at => Time.now})

    @invoices << invoice_5
    @invoices << invoice_6
    @invoices << invoice_7

    assert_equal [], @sales_analyst.bottom_merchants_by_invoice_count
  end

  def test_it_finds_which_days_of_the_week_have_the_most_sales
    invoice_5 = Invoice.new({:id => 10, :customer_id => 48, :merchant_id => 12339191, :status => "pending", :created_at => "2009-02-07", :updated_at => Time.now})
    invoice_6 = Invoice.new({:id => 11, :customer_id => 48, :merchant_id => 12339191, :status => "pending", :created_at => "2009-02-07", :updated_at => Time.now})
    invoice_7 = Invoice.new({:id => 12, :customer_id => 48, :merchant_id => 12339191, :status => "pending", :created_at => "2009-02-07", :updated_at => Time.now})
    invoice_8 = Invoice.new({:id => 10, :customer_id => 48, :merchant_id => 12339191, :status => "pending", :created_at => "2009-02-07", :updated_at => Time.now})
    invoice_9 = Invoice.new({:id => 11, :customer_id => 48, :merchant_id => 12339191, :status => "pending", :created_at => "2009-02-07", :updated_at => Time.now})
    invoice_10 = Invoice.new({:id => 12, :customer_id => 48, :merchant_id => 12339191, :status => "pending", :created_at => "2012-11-23", :updated_at => Time.now})
    invoice_11= Invoice.new({:id => 10, :customer_id => 48, :merchant_id => 12339191, :status => "pending", :created_at => "2012-11-23", :updated_at => Time.now})
    invoice_12 = Invoice.new({:id => 11, :customer_id => 48, :merchant_id => 12339191, :status => "pending", :created_at => "2012-11-23", :updated_at => Time.now})
    invoice_13 = Invoice.new({:id => 12, :customer_id => 48, :merchant_id => 12339191, :status => "pending", :created_at => "2015-03-12", :updated_at => Time.now})

    @invoices << invoice_5
    @invoices << invoice_6
    @invoices << invoice_7
    @invoices << invoice_8
    @invoices << invoice_9
    @invoices << invoice_10
    @invoices << invoice_11
    @invoices << invoice_12
    @invoices << invoice_13

    assert_equal ["Saturday"], @sales_analyst.top_days_by_invoice_count
  end

  def test_finds_invoices_per_day
    invoice_5 = Invoice.new({:id => 10, :customer_id => 48, :merchant_id => 12339191, :status => :pending, :created_at => "2009-02-07", :updated_at => Time.now})
    invoice_6 = Invoice.new({:id => 11, :customer_id => 48, :merchant_id => 12339191, :status => :pending, :created_at => "2009-02-07", :updated_at => Time.now})
    invoice_7 = Invoice.new({:id => 12, :customer_id => 48, :merchant_id => 12339191, :status => :pending, :created_at => "2009-02-07", :updated_at => Time.now})
    invoice_8 = Invoice.new({:id => 10, :customer_id => 48, :merchant_id => 12339191, :status => :pending, :created_at => "2009-02-07", :updated_at => Time.now})
    invoice_9 = Invoice.new({:id => 11, :customer_id => 48, :merchant_id => 12339191, :status => :shipped, :created_at => "2009-02-07", :updated_at => Time.now})
    invoice_10 = Invoice.new({:id => 12, :customer_id => 48, :merchant_id => 12339191, :status => :shipped, :created_at => "2012-11-23", :updated_at => Time.now})
    invoice_11 = Invoice.new({:id => 10, :customer_id => 48, :merchant_id => 12339191, :status => :shipped, :created_at => "2012-11-23", :updated_at => Time.now})
    invoice_12 = Invoice.new({:id => 11, :customer_id => 48, :merchant_id => 12339191, :status => :returned, :created_at => "2012-11-23", :updated_at => Time.now})
    invoice_13 = Invoice.new({:id => 12, :customer_id => 48, :merchant_id => 12339191, :status => :returned, :created_at => "2015-03-12", :updated_at => Time.now})

    @invoices << invoice_5
    @invoices << invoice_6
    @invoices << invoice_7
    @invoices << invoice_8
    @invoices << invoice_9
    @invoices << invoice_10
    @invoices << invoice_11
    @invoices << invoice_12
    @invoices << invoice_13

    expected = {"Saturday" => 9, "Friday" => 3, "Thursday" => 1}

    assert_equal expected, @sales_analyst.weekday_breakdown
  end


  def test_percentage_of_invoices_shipped_based_on_status
    invoice_5 = Invoice.new({:id => 10, :customer_id => 48, :merchant_id => 12339191, :status => :pending, :created_at => "2009-02-07", :updated_at => Time.now})
    invoice_6 = Invoice.new({:id => 11, :customer_id => 48, :merchant_id => 12339191, :status => :pending, :created_at => "2009-02-07", :updated_at => Time.now})
    invoice_7 = Invoice.new({:id => 12, :customer_id => 48, :merchant_id => 12339191, :status => :pending, :created_at => "2009-02-07", :updated_at => Time.now})
    invoice_8 = Invoice.new({:id => 10, :customer_id => 48, :merchant_id => 12339191, :status => :pending, :created_at => "2009-02-07", :updated_at => Time.now})
    invoice_9 = Invoice.new({:id => 11, :customer_id => 48, :merchant_id => 12339191, :status => :shipped, :created_at => "2009-02-07", :updated_at => Time.now})
    invoice_10 = Invoice.new({:id => 12, :customer_id => 48, :merchant_id => 12339191, :status => :shipped, :created_at => "2012-11-23", :updated_at => Time.now})
    invoice_11= Invoice.new({:id => 10, :customer_id => 48, :merchant_id => 12339191, :status => :shipped, :created_at => "2012-11-23", :updated_at => Time.now})
    invoice_12 = Invoice.new({:id => 11, :customer_id => 48, :merchant_id => 12339191, :status => :returned, :created_at => "2012-11-23", :updated_at => Time.now})
    invoice_13 = Invoice.new({:id => 12, :customer_id => 48, :merchant_id => 12339191, :status => :returned, :created_at => "2015-03-13", :updated_at => Time.now})

    @invoices << invoice_5
    @invoices << invoice_6
    @invoices << invoice_7
    @invoices << invoice_8
    @invoices << invoice_9
    @invoices << invoice_10
    @invoices << invoice_11
    @invoices << invoice_12
    @invoices << invoice_13

    assert_equal 61.54, @sales_analyst.invoice_status(:pending)
    assert_equal 23.08, @sales_analyst.invoice_status(:shipped)
    assert_equal 15.38, @sales_analyst.invoice_status(:returned)
  end
end
