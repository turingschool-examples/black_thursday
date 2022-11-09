require './lib/sales_engine'
require './lib/sales_analyst'

RSpec.describe SalesAnalyst do
  before(:all) do
    @sales_engine = SalesEngine.from_csv({
                           items: './data/items.csv',
                           merchants: './data/merchants.csv',
                           invoices: './data/invoices.csv',
                           invoice_items: './data/invoice_items.csv',
                           transactions: "./data/transactions.csv",
                           :customers => "./data/customers.csv"
                         })
   end

  it 'exists' do
    sales_analyst = @sales_engine.analyst
    expect(sales_analyst).to be_instance_of(SalesAnalyst)
  end

  it 'checks average items per merchant' do
    sales_analyst = @sales_engine.analyst
    expect(sales_analyst.average_items_per_merchant).to eq(2.88)
  end

  it 'checks average items per merchant standard deviation' do
    sales_analyst = @sales_engine.analyst
    expect(sales_analyst.average_items_per_merchant_standard_deviation).to eq(3.26)
  end

  it 'returns merchants with high item counts' do
    sales_analyst = @sales_engine.analyst
    expect(sales_analyst.merchants_with_high_item_count).to be_a(Array)
    expect(sales_analyst.merchants_with_high_item_count[0]).to be_a(Merchant)
  end

  it '#average average price per merchant' do
    sales_analyst = @sales_engine.analyst
    expect(sales_analyst.average_average_price_per_merchant).to be_a(BigDecimal)
  end

  it '#golden items' do
  sales_analyst = @sales_engine.analyst
  expect(sales_analyst.golden_items).to be_a(Array)
  expect(sales_analyst.golden_items[0]).to be_a(Item)
  end

  it '#average_invoices_per_merchant' do
    sales_analyst = @sales_engine.analyst
    expect(sales_analyst.average_invoices_per_merchant).to eq(10.49)
  end

  it "#average_invoices_per_merchant_standard_deviation" do
    sales_analyst = @sales_engine.analyst
    expect(sales_analyst.average_invoices_per_merchant_standard_deviation).to eq(3.29)
  end

  it "#merchants_invoices" do
    sales_analyst = @sales_engine.analyst
    expect(sales_analyst.merchants_invoices).to be_instance_of(Array)
  end

  xit "#top_merchants_by_invoice_count" do
    sales_analyst = @sales_engine.analyst
    # expect(sales_analyst.merchant_ids_collection(merchants_invoices)).to be_instance_of(Array)
    # expect(sales_analyst.chosen_merchants(merchants_invoices)).to be_instance_of(Array)
    expect(sales_analyst.top_merchants_by_invoice_count).to be_instance_of(Array)
    expect(sales_analyst.top_merchants_by_invoice_count.length).to eq(12)
  end

  xit "#bottom_merchants_by_invoice_count" do
    sales_analyst = @sales_engine.analyst
    expect(sales_analyst.bottom_merchants_by_invoice_count).to be_instance_of(Array)
    expect(sales_analyst.bottom_merchants_by_invoice_count.length).to eq(4)
  end

  it "#top_days_by_invoice_count" do
    sales_analyst = @sales_engine.analyst
    expect(sales_analyst.dates).to be_instance_of(Array)
    expect(sales_analyst.weekdays).to include("Monday")
    expect(sales_analyst.weekdays).to include("Thursday")
    expect(sales_analyst.weekday_counts).to be_instance_of(Hash)
    expect(sales_analyst.weekday_counts.count).to eq(7)
    expect(sales_analyst.weekday_invoice_avg.class).to eq(Integer)
    expect(sales_analyst.weekday_inv_stndrd_dev.class).to eq(Float)
    expect(sales_analyst.top_days_by_invoice_count).to eq(["Wednesday"])
  end

  it "#invoice_status" do
    sales_analyst = @sales_engine.analyst
    expect(sales_analyst.invoice_status(:pending)).to eq(29.55)
    expect(sales_analyst.invoice_status(:shipped)).to eq(56.95)
    expect(sales_analyst.invoice_status(:returned)).to eq(13.5) 
  end
  
  context 'create invoice' do
    let(:invoice) { sales_engine.invoice_repository.create ({
          id: 1,
          customer_id: 1,
          merchant_id: 12335938,
          status: "pending",
          created_at: Time.now,
          updated_at: Time.now
          })}
  it '#invoice_paid_in_full?' do
    sales_analyst = @sales_engine.analyst
    expect(sales_analyst.invoice_paid_in_full?(12343)).to eq(false)
    transaction = @sales_engine.transactions.create({
    :invoice_id => 12343,
    :credit_card_number => "4242424242424242",
    :credit_card_expiration_date => "0220",
    :result => "success",
    :created_at => Time.now,
    :updated_at => Time.now
  })
  expect(sales_analyst.invoice_paid_in_full?(12343)).to eq(true)
  end

  it '#invoice_total returns the total $ amount of the 
      Invoice with the corresponding id.' do

        sales_analyst = @sales_engine.analyst
        @sales_engine.invoice_items.create({
          :id => 1234321,
          :item_id => 7,
          :invoice_id => 1234321,
          :quantity => 10,
          :unit_price => BigDecimal(10.99, 4),
          :created_at => Time.now,
          :updated_at => Time.now
        })
        
        expect(sales_analyst.invoice_total(1234321)).to eq(109.90)
  end

  it "#merchants_with_pending_invoices" do
    sales_analyst = @sales_engine.analyst
    expect(sales_analyst.merchants_with_pending_invoices).to be_instance_of(Array)
    expect(sales_analyst.merchants_with_pending_invoices.sample).to be_instance_of(Merchant)
  end

  it 'finds merchants with only one item' do
    sales_analyst = @sales_engine.analyst

    expect(sales_analyst.merchants_with_only_one_item).to be_a(Array)
    expect(sales_analyst.merchants_with_only_one_item[0]).to be_a(Merchant)
  end

    it '#merchants_with_only_one_item_registered_in_month' do
      sales_analyst = @sales_engine.analyst
      expect(sales_analyst.merchants_with_only_one_item_registered_in_month('January')).to be_a(Array)
      expect(sales_analyst.merchants_with_only_one_item_registered_in_month('January')[0]).to be_instance_of(Merchant)
    end

    it '#total_revenue_by_date' do
      sales_analyst = @sales_engine.analyst
      expect(sales_analyst.total_revenue_by_date(Time.parse('2009-02-07'))).to be_instance_of(BigDecimal)
    end

    it 'totals revenue by merchant' do
      sales_analyst = @sales_engine.analyst

      expect(sales_analyst.revenue_by_merchant(12334160)).to be_a(BigDecimal)
    end

    it '#most_sold_item_for_merchant' do
     sales_analyst = @sales_engine.analyst
     expect(sales_analyst.most_sold_item_for_merchant(12334105)).to be_a(Array)
     expect(sales_analyst.most_sold_item_for_merchant(12334105)[0]).to be_instance_of(Item)
     expect(sales_analyst.most_sold_item_for_merchant(12334105)[0].id).to eq(263541512)
    end

    xit '#top_revenue_earners' do
    sales_analyst = @sales_engine.analyst
    expect(sales_analyst.top_revenue_earners(5)).to be_a(Array)
    expect(sales_analyst.top_revenue_earners(5).count).to eq(5)
    expect(sales_analyst.top_revenue_earners(5)[0]).to be_instance_of(Merchant)
    end

    it '#best_item_for_merchant' do
      sales_analyst = @sales_engine.analyst
      expect(sales_analyst.best_item_for_merchant(12334496)).to be_instance_of(Item)
      expect(sales_analyst.best_item_for_merchant(12334496).id).to eq(263524340)
      expect(sales_analyst.best_item_for_merchant(12337341).id).to eq(263431343)
      expect(sales_analyst.best_item_for_merchant(12335254).id).to eq(263535488)
    end
  end
end