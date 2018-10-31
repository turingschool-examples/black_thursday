require_relative './test_helper'
require 'time'

class SalesAnalystTest < Minitest::Test

  def setup
    @merchant_1 = Merchant.new({id: 5, name: 'Steve'})
    @merchant_2 = Merchant.new({id: 10, name: 'Turing School'})
    @merchant_3 = Merchant.new({id: 7, name: 'Turk'})
    @merchant_4 = Merchant.new({id: 20, name: 'Margie'})
    @merchant_5 = Merchant.new({id:420, name: 'Rod'})
    @merchant_6 = Merchant.new({id: 666, name: 'Satan'})
    @merchant_7 = Merchant.new({id: 21, name: 'Steve'})
    @merchant_8 = Merchant.new({id: 22, name: 'Turing School'})
    @merchant_9 = Merchant.new({id: 23, name: 'Turk'})
    @merchant_10 = Merchant.new({id: 24, name: 'Margie'})
    @merchant_11 = Merchant.new({id: 25, name: 'Rod'})
    @merchant_12 = Merchant.new({id: 26, name: 'Satan'})
    @merchant_13 = Merchant.new({id: 27, name: 'Steve'})
    @merchant_14 = Merchant.new({id: 28, name: 'Turing School'})
    @merchant_15 = Merchant.new({id: 29, name: 'Turk'})
    @merchant_16 = Merchant.new({id: 30, name: 'Margie'})
    @merchant_17 = Merchant.new({id: 31, name: 'Rod'})
    @merchant_18 = Merchant.new({id: 32, name: 'Satan'})
    @merchant_19 = Merchant.new({id: 33, name: 'Margie'})
    @merchant_20 = Merchant.new({id: 34, name: 'Rod'})
    @merchant_21 = Merchant.new({id: 35, name: 'Satan'})
    @merchants = [@merchant_1, @merchant_2, @merchant_3]
    @merchants_2 = [@merchant_1, @merchant_2, @merchant_3, @merchant_4,    @merchant_5, @merchant_6]
    @merchants_3 = [@merchant_1, @merchant_2, @merchant_3, @merchant_4,  @merchant_5, @merchant_6, @merchant_7, @merchant_8, @merchant_9,  @merchant_10, @merchant_11, @merchant_12, @merchant_13, @merchant_14,   @merchant_15, @merchant_16, @merchant_17, @merchant_18, @merchant_19,  @merchant_20, @merchant_21]
    @mr = MerchantRepository.new(@merchants)
    @mr_2 = MerchantRepository.new(@merchants_2)

    @time = Time.now.to_s
    @item_1 = Item.new({
              :id          => 1,
              :name        => "Pencil",
              :description => "You can use it to write things",
              :unit_price  => 1099,
              :created_at  => @time,
              :updated_at  => @time,
              :merchant_id => 10
            })
    @item_2 = Item.new({
              :id          => 2,
              :name        => "Pen",
              :description => "You can use it to write things in ink!",
              :unit_price  => 3299,
              :created_at  => @time,
              :updated_at  => @time,
              :merchant_id => 10
            })
    @item_3 = Item.new({
              :id          => 3,
              :name        => "Glitter Scrabble",
              :description => "Why wouldn't you want glitter on your scrabble",
              :unit_price  => 4999,
              :created_at  => @time,
              :updated_at  => @time,
              :merchant_id => 5
            })
    @item_4 = Item.new({
              :id          => 4,
              :name        => "3-d printed Dinosaur",
              :description => "It's awesome",
              :unit_price  => 299,
              :created_at  => @time,
              :updated_at  => @time,
              :merchant_id => 5
            })
    @item_5 = Item.new({
              :id          => 5,
              :name        => "Passing RSpec harness",
              :description => "You know you want it",
              :unit_price  => 15901,
              :created_at  => @time,
              :updated_at  => @time,
              :merchant_id => 7
            })
    @item_6 = Item.new({
              :id          => 6,
              :name        => "BigDecimal",
              :description => "why",
              :unit_price  => 104679,
              :created_at  => @time,
              :updated_at  => @time,
              :merchant_id => 47
            })
    @items = [@item_1, @item_2, @item_3, @item_4, @item_5]
    @items_2 = [@item_1, @item_2, @item_3, @item_4, @item_5, @item_6]

    @invoice_1 = Invoice.new({
                :id          => 1,
                :customer_id => 10,
                :merchant_id => 5,
                :status      => "pending",
                :created_at  => "2012-02-26 20:56:56 UTC,2012-02-26",
                :updated_at  => @time
              })
    @invoice_2 = Invoice.new({
                :id          => 2,
                :customer_id => 20,
                :merchant_id => 10,
                :status      => "shipped",
                :created_at  => "2012-02-26 20:56:56 UTC,2012-02-26",
                :updated_at  => @time
              })
    @invoice_3 = Invoice.new({
                :id          => 3,
                :customer_id => 30,
                :merchant_id => 7,
                :status      => "returned",
                :created_at  => "2009-02-09",
                :updated_at  => @time
              })
    @invoice_4 = Invoice.new({
                :id          => 4,
                :customer_id => 40,
                :merchant_id => 5,
                :status      => "returned",
                :created_at  => "2009-02-10",
                :updated_at  => @time
              })
    @invoice_5 = Invoice.new({
                :id          => 5,
                :customer_id => 40,
                :merchant_id => 7,
                :status      => "shipped",
                :created_at  => "2009-02-11",
                :updated_at  => @time
              })
    @invoice_6 = Invoice.new({
                :id          => 6,
                :customer_id => 40,
                :merchant_id => 7,
                :status      => "shipped",
                :created_at  => "2009-02-12",
                :updated_at  => @time
              })
    @invoice_7 = Invoice.new({
                :id          => 7,
                :customer_id => 40,
                :merchant_id => 7,
                :status      => "shipped",
                :created_at  => "2009-02-13",
                :updated_at  => @time
              })
    @invoice_8 = Invoice.new({
                :id          => 8,
                :customer_id => 40,
                :merchant_id => 7,
                :status      => "shipped",
                :created_at  => "2009-02-07",
                :updated_at  => @time
              })
    @invoice_9 = Invoice.new({
                :id          => 9,
                :customer_id => 40,
                :merchant_id => 7,
                :status      => "shipped",
                :created_at  => "2009-02-07",
                :updated_at  => @time
              })
    @invoice_10 = Invoice.new({
                :id          => 10,
                :customer_id => 40,
                :merchant_id => 7,
                :status      => "shipped",
                :created_at  => "2009-02-07",
                :updated_at  => @time
              })
    @invoice_11 = Invoice.new({
                :id          => 11,
                :customer_id => 40,
                :merchant_id => 7,
                :status      => "shipped",
                :created_at  => "2009-02-07",
                :updated_at  => @time
              })
    @invoice_12 = Invoice.new({
                :id          => 12,
                :customer_id => 40,
                :merchant_id => 7,
                :status      => "shipped",
                :created_at  => "2009-02-07",
                :updated_at  => @time
              })
    @invoice_13 = Invoice.new({
                :id          => 13,
                :customer_id => 40,
                :merchant_id => 7,
                :status      => "shipped",
                :created_at  => "2009-02-07",
                :updated_at  => @time
              })
    @invoice_14 = Invoice.new({
                :id          => 14,
                :customer_id => 40,
                :merchant_id => 7,
                :status      => "shipped",
                :created_at  => "2009-02-07",
                :updated_at  => @time
              })
    @invoice_15 = Invoice.new({
                :id          => 15,
                :customer_id => 40,
                :merchant_id => 7,
                :status      => "shipped",
                :created_at  => "2009-02-07",
                :updated_at  => @time
              })
    @invoice_16 = Invoice.new({
                :id          => 16,
                :customer_id => 40,
                :merchant_id => 7,
                :status      => "shipped",
                :created_at  => "2009-02-07",
                :updated_at  => @time
              })
    @invoice_17 = Invoice.new({
                :id          => 17,
                :customer_id => 40,
                :merchant_id => 7,
                :status      => "shipped",
                :created_at  => "2009-02-07",
                :updated_at  => @time
              })
    @invoice_18 = Invoice.new({
                :id          => 18,
                :customer_id => 40,
                :merchant_id => 7,
                :status      => "shipped",
                :created_at  => "2009-02-07",
                :updated_at  => @time
              })
    @invoice_19 = Invoice.new({
                :id          => 19,
                :customer_id => 40,
                :merchant_id => 7,
                :status      => "shipped",
                :created_at  => "2009-02-07",
                :updated_at  => @time
              })

    @invoices = [@invoice_1, @invoice_2, @invoice_3, @invoice_4, @invoice_5]
    @invoices_2 = [@invoice_1, @invoice_2, @invoice_3, @invoice_4,
                  @invoice_5, @invoice_6, @invoice_7, @invoice_8, @invoice_9, @invoice_10,
                  @invoice_11, @invoice_12, @invoice_13, @invoice_14, @invoice_15, @invoice_16,
                  @invoice_17, @invoice_18, @invoice_19]

    @invoice_item_1 = InvoiceItem.new({ id: "1",
                                        item_id: "10",
                                        invoice_id: "1",
                                        quantity: "4",
                                        unit_price: "2500",
                                        created_at: @time,
                                        updated_at: @time
                                      })
    @invoice_item_2 = InvoiceItem.new({ id: "2",
                                        item_id: "10",
                                        invoice_id: "2",
                                        quantity: "4",
                                        unit_price: "2500",
                                        created_at: @time,
                                        updated_at: @time
                                      })
    @invoice_item_3 = InvoiceItem.new({ id: "3",
                                        item_id: "10",
                                        invoice_id: "3",
                                        quantity: "4",
                                        unit_price: "2500",
                                        created_at: @time,
                                        updated_at: @time
                                      })
    @invoice_item_4 = InvoiceItem.new({ id: "4",
                                        item_id: "5",
                                        invoice_id: "2",
                                        quantity: "4",
                                        unit_price: "2500",
                                        created_at: @time,
                                        updated_at: @time
                                      })
    @invoice_item_5 = InvoiceItem.new({ id: "5",
                                        item_id: "5",
                                        invoice_id: "2",
                                        quantity: "4",
                                        unit_price: "2500",
                                        created_at: @time,
                                        updated_at: @time
                                      })
    @invoice_item_6 = InvoiceItem.new({ id: "6",
                                        item_id: "4",
                                        invoice_id: "2",
                                        quantity: "4",
                                        unit_price: "2500",
                                        created_at: @time,
                                        updated_at: @time
                                      })
    @invoice_item_7 = InvoiceItem.new({ id: "6",
                                        item_id: "1",
                                        invoice_id: "2",
                                        quantity: "4",
                                        unit_price: "2500",
                                        created_at: @time,
                                        updated_at: @time
                                      })
    @invoice_item_8 = InvoiceItem.new({ id: "6",
                                        item_id: "2",
                                        invoice_id: "2",
                                        quantity: "4",
                                        unit_price: "2500",
                                        created_at: @time,
                                        updated_at: @time
                                      })


    @transaction_1 = Transaction.new({
                        :id => 6,
                        :invoice_id => 1,
                        :credit_card_number => "4242424242424242",
                        :credit_card_expiration_date => "0220",
                        :result => "success",
                        :created_at => "2012-02-26 20:56:56 UTC,2012-02-26",
                        :updated_at => @time
                      })
    @transaction_2 = Transaction.new({
                        :id => 7,
                        :invoice_id => 2,
                        :credit_card_number => "4613250127567219",
                        :credit_card_expiration_date => "0223",
                        :result => "success",
                        :created_at => "2012-02-26 20:56:56 UTC,2012-02-26",
                        :updated_at => @time
                      })
    @transaction_3 = Transaction.new({
                        :id => 8,
                        :invoice_id => 2,
                        :credit_card_number => "4558368405929183",
                        :credit_card_expiration_date => "0417",
                        :result => "failed",
                        :created_at => @time,
                        :updated_at => @time
                      })
    @transaction_4 = Transaction.new({
                        :id => 9,
                        :invoice_id => 3,
                        :credit_card_number => "4558368405929183",
                        :credit_card_expiration_date => "0417",
                        :result => "failed",
                        :created_at => @time,
                        :updated_at => @time
                      })
    @invoice_items = [@invoice_item_1, @invoice_item_2, @invoice_item_3]
    @invoice_items_2 = [@invoice_item_1, @invoice_item_2, @invoice_item_3, @invoice_item_4, @invoice_item_5, @invoice_item_6]
    @invoice_items_3 = [@invoice_item_1, @invoice_item_2, @invoice_item_3, @invoice_item_7, @invoice_item_8]
    @transactions = [@transaction_1, @transaction_2, @transaction_3, @transaction_4]

    sales_engine = SalesEngine.new(@items, @merchants, @invoices, nil, nil, nil)
    @sales_analyst = sales_engine.analyst
    sales_engine_2 = SalesEngine.new(@items, @merchants_2, @invoices_2, @transactions, nil, @invoice_items)
    @sales_analyst_2 = sales_engine_2.analyst
    sales_engine_3 = SalesEngine.new(@items, @merchants_3, @invoices_2, @transactions, nil, @invoice_items_2)
    @sales_analyst_3 = sales_engine_3.analyst
    sales_engine_4 = SalesEngine.new(@items, @merchants_2, @invoices_2, @transactions, nil, @invoice_items_3)
    @sales_analyst_4 = sales_engine_4.analyst
  end

  def test_it_exists
    assert_instance_of SalesAnalyst, @sales_analyst
  end

  def test_it_can_be_created_by_sales_engine
    sales_engine = SalesEngine.from_csv({
    :items     => "./data/item_test.csv",
    :merchants => "./data/merchant_test.csv",
    :invoices => "./data/invoices.csv",
    :invoice_items => "./data/invoice_items.csv"
    })
    sales_analyst = sales_engine.analyst
    assert_instance_of SalesAnalyst, sales_analyst
  end

  def test_it_can_count_merchants
    assert_equal 3, @sales_analyst.count_of_merchants
  end

  def test_it_can_calculate_the_average_number_of_items_per_merchant
    assert_equal 1.67, @sales_analyst.average_items_per_merchant
  end

  def test_analyst_can_find_which_merchants_sells_the_most
    merchant_1 = Merchant.new({id: 5, name: 'Steve'})
    merchant_2 = Merchant.new({id: 10, name: 'Turing School'})
    merchant_3 = Merchant.new({id: 7, name: 'Turk'})
    merchants = [merchant_1, merchant_2, merchant_3]
    time = Time.now.to_s
    item_1 = Item.new({
              :id          => 1,
              :name        => "Pencil",
              :description => "You can use it to write things",
              :unit_price  => BigDecimal.new(10.99,4),
              :created_at  => time,
              :updated_at  => time,
              :merchant_id => 5
            })
    item_2 = Item.new({
              :id          => 2,
              :name        => "Pen",
              :description => "You can use it to write things in ink!",
              :unit_price  => BigDecimal.new(32.99,4),
              :created_at  => time,
              :updated_at  => time,
              :merchant_id => 5
            })
    item_3 = Item.new({
              :id          => 3,
              :name        => "Glitter Scrabble",
              :description => "Why wouldn't you want glitter on your scrabble",
              :unit_price  => BigDecimal.new(49.99,4),
              :created_at  => time,
              :updated_at  => time,
              :merchant_id => 5
            })
    item_4 = Item.new({
              :id          => 4,
              :name        => "3-d printed Dinosaur",
              :description => "It's awesome",
              :unit_price  => BigDecimal.new(2.99,3),
              :created_at  => time,
              :updated_at  => time,
              :merchant_id => 5
            })
    item_5 = Item.new({
              :id          => 5,
              :name        => "Passing RSpec harness",
              :description => "You know you want it",
              :unit_price  => BigDecimal.new(159.01,5),
              :created_at  => time,
              :updated_at  => time,
              :merchant_id => 7
            })
    items = [item_1, item_2, item_3, item_4, item_5]
    sales_engine = SalesEngine.new(items, merchants, nil, nil, nil, nil)
    sales_analyst = SalesAnalyst.new(sales_engine)
    expected = [merchant_1]
    assert_equal expected, sales_analyst.merchants_with_high_item_count
  end

  def test_it_can_average_price_of_items_by_merchant
    average_1 = @sales_analyst.average_item_price_for_merchant(5)
    average_2 = @sales_analyst.average_item_price_for_merchant(10)
    assert_equal BigDecimal(26.49, 4), average_1
    assert_equal BigDecimal(21.99, 4), average_2
  end

  def test_it_can_calculate_mean
    nums = [1, 2, 3, 4]
    assert_equal 2.5, @sales_analyst.mean(nums)
  end

  def test_it_can_calulate_sum
    nums = [1, 2, 3, 4]
    assert_equal 10, @sales_analyst.sum(nums)
  end

  def test_it_can_calculate_std_deviation
    nums = [1, 2, 3, 4]
    assert_equal 1.29, @sales_analyst.std_dev(nums)
  end

  def test_it_returns_num_items_per_merchant
    expected = {@merchant_1 => 2, @merchant_2 => 2, @merchant_3 => 1}
    assert_equal expected, @sales_analyst.num_items_for_each_merchant
  end

  def test_it_can_calculate_average_items_per_merchant_std_deviation
    assert_equal 0.58, @sales_analyst.average_items_per_merchant_standard_deviation
  end

  def test_it_can_calculate_average_average_price_per_merchant
    assert_equal BigDecimal.new(69.16, 4), @sales_analyst.average_average_price_per_merchant
  end

  def test_it_can_find_golden_items
    sales_engine = SalesEngine.new(@items_2, @merchants, @invoices, nil, nil, nil)
    sales_analyst = SalesAnalyst.new(sales_engine)
    assert_equal [@item_6], sales_analyst.golden_items
  end

  def test_it_can_get_average_invoices
    sales = @sales_analyst.average_invoices_per_merchant
    assert_equal 1.67, sales
  end

  def test_it_can_get_standard_deviation_of_invoices
    sales = @sales_analyst.average_invoices_per_merchant_standard_deviation

    assert_equal 0.58, sales
  end

  def test_it_can_get_top_merchant_invoices_two_deviations_above
    sales = @sales_analyst_2.top_merchants_by_invoice_count

    assert_equal [@merchant_3], sales
  end

  def test_it_can_find_bottom_merchants_by_invoices_two_deviations_below
    sales = @sales_analyst_2.bottom_merchants_by_invoice_count

    assert_equal [@merchant_4, @merchant_5, @merchant_6], sales
  end

  def test_it_can_get_top_days_by_invoice_count
    sales = @sales_analyst_2.top_days_by_invoice_count
    days = ["Saturday"]

    assert_equal days, sales
  end

  def test_it_can_get_invoice_status_percentage
    stats_1 = @sales_analyst_2.invoice_status(:pending)
    stats_2 = @sales_analyst_2.invoice_status(:shipped)
    stats_3 = @sales_analyst_2.invoice_status(:returned)
    percentage_total = stats_1 + stats_2 + stats_3
    assert_equal 5.26, stats_1
    assert_equal 84.21, stats_2
    assert_equal 10.53, stats_3
    assert_equal 100.0, percentage_total
  end

  def test_it_can_see_if_invoice_is_paid_in_full
    assert @sales_analyst_2.invoice_paid_in_full?(2)
    refute @sales_analyst_2.invoice_paid_in_full?(3)
    refute @sales_analyst_2.invoice_paid_in_full?(42)
  end

  def test_it_can_return_invoice_total_amount
    assert_equal BigDecimal.new(100.00, 5), @sales_analyst_2.invoice_total(2)
  end

  def test_it_can_find_total_revenue_by_date
    date  = Time.parse("2012-02-26")
    expected = BigDecimal(200.00, 5)
    assert_equal expected, @sales_analyst_2.total_revenue_by_date(date)
  end

  def test_it_can_find_top_indicated_number_of_merchants_for_revenue
    expected = [@merchant_2, @merchant_1]
    expected_2 = [@merchant_2, @merchant_1, @merchant_3, @merchant_4,  @merchant_5, @merchant_6, @merchant_7, @merchant_8, @merchant_9,  @merchant_10, @merchant_11, @merchant_12, @merchant_13, @merchant_14,   @merchant_15, @merchant_16, @merchant_17, @merchant_18, @merchant_19,  @merchant_20]
    assert_equal expected, @sales_analyst_3.top_revenue_earners(2)
    assert @sales_analyst_3.top_revenue_earners.all? {|r| expected_2.include? r}
  end

  def test_it_can_find_which_merchants_have_pending_invoices
    expected = [@merchant_3, @merchant_1]
    assert_equal expected, @sales_analyst_2.merchants_with_pending_invoices
  end

  def test_it_can_find_which_merchants_only_sell_one_item
    assert_equal [@merchant_3], @sales_analyst_2.merchants_with_only_one_item
  end

  def test_it_can_find_merchants_that_only_sell_one_item_in_registered_month
    skip
    actual = @sales_analyst_2.merchants_with_only_one_item_registered_in_month("February")
    assert_equal [@merchant_2], actual
  end

  def test_it_can_calculate_total_revenue_for_a_merchant
    expected = BigDecimal.new(200.00, 5)
    assert_equal expected, @sales_analyst_4.revenue_by_merchant(10)
  end

  def test_it_can_calculate_most_sold_items_for_a_merchant
    skip
    assert_equal [@item_4], @sales_analyst_3.most_sold_item_for_merchant(10)
  end

  def test_it_can_find_item_that_generates_most_revenue_for_merchant
    skip
    assert_equal @item_3, @sales_analyst.best_item_for_merchant(10)
  end
  
  def test_it_can_rank_merchants_by_revenue
    merchant_1 = mock
    merchant_1.stubs(:id).returns(1)
    merchant_2 = mock
    merchant_2.stubs(:id).returns(2)
    merchant_3 = mock
    merchant_3.stubs(:id).returns(3)
    invoice_1 = mock
    invoice_1.stubs(:id).returns(1)
    invoice_1.stubs(:merchant_id).returns(1)
    invoice_2 = mock
    invoice_2.stubs(:id).returns(2)
    invoice_2.stubs(:merchant_id).returns(2)
    invoice_3 = mock
    invoice_3.stubs(:id).returns(3)
    invoice_3.stubs(:merchant_id).returns(3)
    transaction_1 = mock
    transaction_1.stubs(:id).returns(1)
    transaction_1.stubs(:invoice_id).returns(1)
    transaction_1.stubs(:result).returns(:success)
    transaction_2 = mock
    transaction_2.stubs(:id).returns(2)
    transaction_2.stubs(:invoice_id).returns(2)
    transaction_2.stubs(:result).returns(:success)
    transaction_3 = mock
    transaction_3.stubs(:id).returns(3)
    transaction_3.stubs(:invoice_id).returns(3)
    transaction_3.stubs(:result).returns(:success)
    invoice_item_1 = mock
    invoice_item_1.stubs(:id).returns(1)
    invoice_item_1.stubs(:invoice_id).returns(1)
    invoice_item_1.stubs(:item_id).returns(1)
    invoice_item_1.stubs(:unit_price).returns(BigDecimal.new(10.00, 4))
    invoice_item_1.stubs(:quantity).returns(1)
    invoice_item_2 = mock
    invoice_item_2.stubs(:id).returns(2)
    invoice_item_2.stubs(:invoice_id).returns(2)
    invoice_item_2.stubs(:item_id).returns(2)
    invoice_item_2.stubs(:unit_price).returns(BigDecimal.new(50.00, 4))
    invoice_item_2.stubs(:quantity).returns(2)
    invoice_item_3 = mock
    invoice_item_3.stubs(:id).returns(3)
    invoice_item_3.stubs(:item_id).returns(3)
    invoice_item_3.stubs(:invoice_id).returns(3)
    invoice_item_3.stubs(:unit_price).returns(BigDecimal.new(40.00, 4))
    invoice_item_3.stubs(:quantity).returns(1)
    
    merchants = [merchant_1, merchant_2, merchant_3]
    invoices = [invoice_1, invoice_2, invoice_3]
    invoice_items = [invoice_item_1, invoice_item_2, invoice_item_3]
    transactions = [transaction_1, transaction_2, transaction_3]
    se = SalesEngine.new(nil, merchants, invoices, transactions, nil, invoice_items)
    sales_analyst = se.analyst
    
    expected = [merchant_2, merchant_3, merchant_1]
    assert_equal expected, sales_analyst.merchants_ranked_by_revenue 
    expected = {merchant_1 => [invoice_1], 
                merchant_2 => [invoice_2], 
                merchant_3 => [invoice_3]}
    assert_equal expected, sales_analyst.invoices_for_each_merchant
    expected = {merchant_1 => BigDecimal.new(10.00, 4), 
                merchant_2 => BigDecimal.new(100.00, 5),
                merchant_3 => BigDecimal.new(40.00, 4)}
    assert_equal expected, sales_analyst.revenue_for_each_merchant
  end
end
