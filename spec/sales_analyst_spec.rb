require './lib/sales_engine'
require './lib/sales_analyst'

RSpec.describe SalesAnalyst do
  before(:all) do
    @sales_engine = SalesEngine.from_csv({
                           items: './data/items.csv',
                           merchants: './data/merchants.csv',
                           invoices: './data/invoices.csv',
                           invoice_items: './data/invoice_items.csv',
                           transactions: "./data/transactions.csv"
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

  it "#average_invoices_per_merchang_standard_deviation" do
    sales_analyst = @sales_engine.analyst
    expect(sales_analyst.average_invoices_per_merchant_standard_deviation).to eq(3.29)
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
end

end
