require './lib/sales_analyst'
require './lib/merchant_repository'
require './lib/item_repository'
require 'pry'

describe SalesAnalyst do
  before(:each) do
    @merchants = MerchantRepository.new('./data/merchants.csv')
    @items = ItemRepository.new('./data/items.csv')
    @invoices = InvoiceRepository.new('./data/invoices.csv')
    @invoice_items = InvoiceItemRepository.new('./data/invoice_items.csv')
    @transactions = TransactionRepository.new('./data/transactions.csv')
    @customers = CustomerRepository.new('./data/customers.csv')
    @analyst = SalesAnalyst.new(@items, @merchants, @invoices, @invoice_items, @transactions, @customers)
  end

  it "is an instance of SalesAnalyst" do
    expect(@analyst).to be_a(SalesAnalyst)
  end

  it "creates a hash merchant ids (integers) as keys and counts of items (integer) as values" do
    expect(@analyst.merchant_items_hash.keys.count).to eq(475)
    expect(@analyst.merchant_items_hash).to be_a Hash
    expect(@analyst.merchant_items_hash.first).to be_a Array
    expect(@analyst.merchant_items_hash.first[0]).to be_a Integer
    expect(@analyst.merchant_items_hash.first[1]).to be_a Integer
  end

  it "can give us the average items per merchant" do
    expect(@analyst.average_items_per_merchant).to eq(2.88)
  end

  it "can give us the standard deviation of the items sold" do
    expect(@analyst.average_items_per_merchant_standard_deviation).to eq(3.26)
  end

  it "can give us all the merchants with a high item count" do
    array = @analyst.merchants_with_high_item_count
    expect(array).to be_a Array
    if array.count > 0
      expect(array[0]).to be_a Merchant
    end
  end

  it "can give us the average item price for a merchant" do
    expect(@items.find_all_by_merchant_id(12334105).count).to eq 3
    expect(@analyst.average_item_price_for_merchant(12334105)).to be_a BigDecimal
  end

  it 'can give us the average average item price for a merchant' do
    expect(@analyst.average_average_price_per_merchant).to be_a BigDecimal
  end

  it 'can return the average price per item' do
    expect(@analyst.average_price_per_item).to be_a BigDecimal
  end

  it 'can return the standard deviation of average price per item' do
    expect(@analyst.average_price_per_item_standard_deviation).to be_a BigDecimal
  end

  it 'can return an array of golden items' do
    array = @analyst.golden_items
    expect(array).to be_a Array
    if array.count > 0
      expect(array[0]).to be_a Item
    end
  end

  it 'can return a hash of merchants ids (integers) as keys and count of invoices (integer) as values' do
    expect(@analyst.merchant_invoices_hash).to be_a Hash
    expect(@analyst.merchant_invoices_hash.first).to be_a Array
    expect(@analyst.merchant_invoices_hash.first[0]).to be_a Integer
    expect(@analyst.merchant_invoices_hash.first[1]).to be_a Integer
  end

  it 'can return the average invoices per merchant' do
    expect(@analyst.average_invoices_per_merchant).to eq 10.49
  end

  it 'can return the standard deviation of average invoices per merchant' do
    expect(@analyst.average_invoices_per_merchant_standard_deviation).to eq 3.29
  end

  it 'can return an array of merchants for top_merchants_by_invoice_count' do
    array = @analyst.top_merchants_by_invoice_count
    expect(array).to be_a Array
    if array.count > 0
      expect(array[0]).to be_a Merchant
    end
  end

  it 'can return an array of merchants for bottom_merchants_by_invoice_count' do
    array = @analyst.bottom_merchants_by_invoice_count
    expect(array).to be_a Array
    if array.count > 0
      expect(array[0]).to be_a Merchant
    end
  end

  it 'can return a hash of arrays of days as a string and count of invoices as integers' do
    expect(@analyst.days_invoices_hash).to be_a Hash
    expect(@analyst.days_invoices_hash.first).to be_a Array
    expect(@analyst.days_invoices_hash.first[0]).to be_a String
    expect(@analyst.days_invoices_hash.first[1]).to be_a Integer
  end

  it 'can return the count of average invoices per day' do
    expect(@analyst.average_invoices_per_day).to be_a Float
  end

  it 'can return the standard deviation of average invoices per day' do
    expect(@analyst.average_invoices_per_day_standard_deviation).to be_a Float
  end

  it 'can return an array of top_days_by_invoice_count' do
    array = @analyst.top_days_by_invoice_count
    expect(array).to be_a Array
    if array.count > 0
      expect(array[0]).to be_a String
    end
  end

  it 'can return precent of invoices by status' do
    expect(@analyst.invoice_status(:pending)).to eq 29.55
    expect(@analyst.invoice_status(:shipped)).to eq 56.95
    expect(@analyst.invoice_status(:returned)).to eq 13.5
  end
end
