require './lib/requirements'

RSpec.describe SalesAnalyst do
  let!(:sales_engine) {SalesEngine.from_csv({
    :items     => "./data/items.csv",
    :merchants => "./data/merchants.csv",
    :customers => "./data/customers.csv",
    :invoices => "./data/invoices.csv",
    :invoice_items => "./data/invoice_items.csv",
    :transactions => "./data/transactions.csv"
    })}

  let!(:sales_analyst) {sales_engine.analyst}

  it 'exists' do
    expect(sales_analyst).to be_a(SalesAnalyst)
  end

  it 'has an average number of items per merchant' do
    expect(sales_analyst.average_items_per_merchant).to eq(2.88)
    expect(sales_analyst.average_items_per_merchant).to be_a(Float)
  end

  it 'has a total number of items' do
    expect(sales_analyst.items_count).to eq(1367)
  end
  
  it 'has a total number of merchants' do
    expect(sales_analyst.merchants_count).to eq(475)
  end

  it 'can return the standard deviation of average number of items per merchant' do
    expect(sales_analyst.average_items_per_merchant_standard_deviation).to eq(3.26)
    expect(sales_analyst.average_items_per_merchant_standard_deviation).to be_a(Float)
  end

  it 'can return the merchants with the high item counts' do 
    expect(sales_analyst.merchants_with_high_item_count.length).to eq(52)
    expect(sales_analyst.merchants_with_high_item_count.first.class).to eq(Merchant)
  end

  it 'can return average item price for the given merchant' do
    expect(sales_analyst.average_item_price_for_merchant(12334105)).to eq(16.66)
    expect(sales_analyst.average_item_price_for_merchant(12334105).class).to eq(BigDecimal)
  end

  it 'can return average item price per (all) merchants' do
    expect(sales_analyst.average_average_price_per_merchant).to eq(350.29)
    expect(sales_analyst.average_average_price_per_merchant.class).to eq(BigDecimal)
  end
  
  it 'can return an average price for all items' do #this is a helper method we made; getting a BigDecimal
    expect(sales_analyst.average_price_for_all_items).to eq(25105.51)
    expect(sales_analyst.average_price_for_all_items.class).to eq(BigDecimal)
  end
  
  it 'can return a standard deviation for all items' do #this is a helper method we made; correct now
    expect(sales_analyst.average_standard_deviation_for_all_items).to eq(2900.99)
    expect(sales_analyst.average_standard_deviation_for_all_items.class).to eq(Float)
  end

  it 'can return items that are two standard deviations ABOVE the average ITEM price (golden items)' do #related to above
    expect(sales_analyst.golden_items.length).to eq(5)
    expect(sales_analyst.golden_items.first.class).to eq(Item)
  end

   # ============== ITERATION 2 METHODS ========================= #

  it 'has an average number of invoices per merchant' do
    expect(sales_analyst.average_invoices_per_merchant).to eq(10.49)
    expect(sales_analyst.average_invoices_per_merchant.class).to eq(Float)
  end

  it 'has a total number of invoices' do
    expect(sales_analyst.invoice_count).to eq(4985)
  end
  
  it 'can return the standard deviation of average number of invoices per merchant' do
    expect(sales_analyst.average_invoices_per_merchant_standard_deviation).to eq(3.29)
    expect(sales_analyst.average_invoices_per_merchant_standard_deviation.class).to eq(Float)
  end
  
  it 'can return the merchant with the highest invoice count' do # this is taking a very long time.
    expect(sales_analyst.top_merchants_by_invoice_count.length).to eq(12)
    expect(sales_analyst.top_merchants_by_invoice_count.first.class).to eq(Merchant)
  end
  
  it 'can return the merchant with the lowest invoice count' do # also long time, probably same thing
    expect(sales_analyst.bottom_merchants_by_invoice_count.length).to eq(4)
    expect(sales_analyst.bottom_merchants_by_invoice_count.first.class).to eq(Merchant)
  end
    
  it 'can have a number of invoices per day' do
    expect(sales_analyst.invoice_count_per_day).to be_a(Hash)
    expect(sales_analyst.invoice_count_per_day.values.sum).to eq(sales_analyst.invoice_count)
  end

  it 'can have an average number of invoices per day' do
    expect(sales_analyst.average_invoices_per_day).to eq(712.14)
  end

  it 'can have a standard deviation for all invoices' do
    expect(sales_analyst.average_invoice_standard_deviation).to eq(18.07)
  end

  it 'can return the day with the highest invoice count' do # oddly failed now
    expect(sales_analyst.top_days_by_invoice_count.length).to eq(1)
    expect(sales_analyst.top_days_by_invoice_count.first).to eq("Wednesday")
    expect(sales_analyst.top_days_by_invoice_count.first.class).to eq(String)
  end
  
  it 'can return percentage of invoices that are not shipped' do
    expect(sales_analyst.invoice_status(:pending)).to eq(29.55)
    expect(sales_analyst.invoice_status(:shipped)).to eq(56.95)
    expect(sales_analyst.invoice_status(:returned)).to eq(13.5)
  end

   # ============== ITERATION 3 METHODS ========================= #

  it 'can return true if the invoice with corresponding id is paid in full' do
    sales_analyst.invoice_paid_in_full?(1)
    expect(sales_analyst.invoice_paid_in_full?(1)).to eq(true)

    sales_analyst.invoice_paid_in_full?(200)
    expect(sales_analyst.invoice_paid_in_full?(200)).to eq(true)

    sales_analyst.invoice_paid_in_full?(203)
    expect(sales_analyst.invoice_paid_in_full?(203)).to eq(false)

    sales_analyst.invoice_paid_in_full?(204)
    expect(sales_analyst.invoice_paid_in_full?(204)).to eq(false)
  end

  it 'can return the total dollar amount if the invoice is paid in full ' do
    expect(sales_analyst.invoice_total(1)).to eq(21067.77)
    expect(sales_analyst.invoice_total(1).class).to eq(BigDecimal)
  end

   # ============== ITERATION 4 METHODS ========================= #

   describe 'Iteration 4' do
    let!(:merchant) {sales_engine.merchants.find_by_id(12335523)}

    it 'can find out the total revenue for a given date' do
      date = Time.parse("2009-02-07")

      expect(sales_analyst.total_revenue_by_date(date)).to eq(21067.77)
      expect(sales_analyst.total_revenue_by_date(date).class).to eq BigDecimal
    end

    it 'can return the top x number of merchants ranked by revenue' do
      sales_analyst.top_revenue_earners(10)
  
      expect(sales_analyst.top_revenue_earners(10).length).to eq(10)

      expect(sales_analyst.top_revenue_earners(10).first.class).to eq(Merchant)
      expect(sales_analyst.top_revenue_earners(10).first.id).to eq(12334634)

      expect(sales_analyst.top_revenue_earners(10).last.class).to eq(Merchant)
      expect(sales_analyst.top_revenue_earners(10).last.id).to eq(12335747)
    end

    it 'can return by default the top 20 merchants ranked by revenue if not argument is given' do 
      expect(sales_analyst.top_revenue_earners.length).to eq(20)

      expect(sales_analyst.top_revenue_earners.first.class).to eq(Merchant)
      expect(sales_analyst.top_revenue_earners.first.id).to eq(12334634)

      expect(sales_analyst.top_revenue_earners.last.class).to eq(Merchant)
      expect(sales_analyst.top_revenue_earners.last.id).to eq(12334159)
    end

    it 'can return merchants ranked by revenue' do
      expect(sales_analyst.merchants_ranked_by_revenue.first.class).to eq(Merchant)
      expect(sales_analyst.merchants_ranked_by_revenue.length).to eq(sales_analyst.sales_engine.merchants.all.length)

      expect(sales_analyst.merchants_ranked_by_revenue.first.id).to eq(12334634)
      expect(sales_analyst.merchants_ranked_by_revenue.last.id).to eq(12336175)
    end
    
    it 'can return all merchants with pending invoices' do
      expect(sales_analyst.merchants_with_pending_invoices.length).to eq(467)
      expect(sales_analyst.merchants_with_pending_invoices.first.class).to eq(Merchant)
    end

    it 'can return all merchants with only one item' do
      expect(sales_analyst.merchants_with_only_one_item.length).to eq(243)
      expect(sales_analyst.merchants_with_only_one_item.first.class).to eq(Merchant)
    end

    it 'can return merchants with only one invoice for a given month' do # to be revised
      expect(sales_analyst.merchants_with_only_one_item_registered_in_month("March").length).to eq(21)
      expect(sales_analyst.merchants_with_only_one_item_registered_in_month("March").first.class).to eq(Merchant)

      expect(sales_analyst.merchants_with_only_one_item_registered_in_month("June").length).to eq(18)
      expect(sales_analyst.merchants_with_only_one_item_registered_in_month("June").first.class).to eq(Merchant)
    end

    it 'can return the final revenue for a single merchant' do
      expected = sales_analyst.revenue_by_merchant(12334194)
      expect(expected).to eq(BigDecimal(expected))
      expect(sales_analyst.revenue_by_merchant(12334194).class).to eq(BigDecimal)
    end

    it 'can return the most sold item for a specified merchant' do
      sales_analyst.most_sold_item_for_merchant(12334194)

      expect(sales_analyst.most_sold_item_for_merchant(12334194)).to eq([sales_analyst.sales_engine.items.find_by_id(263539266)])
    end

    it 'can find total for a single invoice_item' do
      expect(sales_analyst.invoice_item_quantity_and_unit_price(sales_analyst.se_invoice_items.find_all_by_item_id(263409279)[2])).to eq(3348.0)
      
    end

    it 'can return the best item (in terms of revenue) for a specified merchant' do
      sales_analyst.best_item_for_merchant(12334634)
      
      expect(sales_analyst.best_item_for_merchant(12334634)).to eq([sales_analyst.se_items.find_by_id(263395721)])
    end
  end
end
