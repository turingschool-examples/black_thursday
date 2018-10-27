require_relative './test_helper'

class SalesAnalystTest < Minitest::Test

  def setup    
    @merchant_1 = Merchant.new({id: 5, name: 'Steve'})
    @merchant_2 = Merchant.new({id: 10, name: 'Turing School'})
    @merchant_3 = Merchant.new({id: 7, name: 'Turk'})
    @merchants = [@merchant_1, @merchant_2, @merchant_3]
    @mr = MerchantRepository.new(@merchants)
    
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
                :merchant_id => 100,
                :status      => "pending",
                :created_at  => @time,
                :updated_at  => @time
              })
    @invoice_2 = Invoice.new({
                :id          => 2,
                :customer_id => 20,
                :merchant_id => 200,
                :status      => "shipped",
                :created_at  => @time,
                :updated_at  => @time
              })
    @invoice_3 = Invoice.new({
                :id          => 3,
                :customer_id => 30,
                :merchant_id => 300,
                :status      => "returned",
                :created_at  => @time,
                :updated_at  => @time
              })
    @invoice_4 = Invoice.new({
                :id          => 4,
                :customer_id => 40,
                :merchant_id => 400,
                :status      => "returned",
                :created_at  => @time,
                :updated_at  => @time
              })
    @invoices = [@invoice_1, @invoice_2, @invoice_3, @invoice_4]
    
    mr = MerchantRepository.new(@merchants)
    ir = ItemRepository.new(@items)
    invoice_repo = InvoiceRepository.new(@invoices)
    
    @sales_analyst = SalesAnalyst.new(ir, mr, invoice_repo)
  end

  def test_it_exists
    assert_instance_of SalesAnalyst, @sales_analyst
  end

  def test_it_can_be_created_by_sales_engine
    sales_engine = SalesEngine.from_csv({
    :items     => "./data/item_test.csv",
    :merchants => "./data/merchant_test.csv",
    :invoices => "./data/invoices.csv"
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
    mr = MerchantRepository.new(merchants)
    
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
    invoices = []
    mr = MerchantRepository.new(merchants)
    ir = ItemRepository.new(items)
    
    sales_analyst = SalesAnalyst.new(ir, mr, invoices)
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
    mr = MerchantRepository.new(@merchants)
    ir = ItemRepository.new(@items_2)
    invoice_repo = InvoiceRepository.new(@invoices)
    
    @sales_analyst = SalesAnalyst.new(ir, mr, invoice_repo)
    assert_equal [@item_6], @sales_analyst.golden_items
  end

end
