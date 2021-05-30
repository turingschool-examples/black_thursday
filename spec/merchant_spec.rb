require 'simplecov'
SimpleCov.start
require './lib/sales_engine'
require './lib/merchant_repository'

RSpec.describe Merchant do
  describe '#initialize' do
    it 'exists' do
      mock_merchant_repo = instance_double('MerchantRepository')
      merchant = Merchant.new(
        {
          id: '12334105',
          name: 'Shopin1901',
          created_at: '2010-12-10',
          updated_at: '2011-12-04'
        }, mock_merchant_repo)

      expect(merchant).to be_a(Merchant)
    end

    it 'has attributes' do
      mock_merchant_repo = instance_double('MerchantRepository')
      merchant = Merchant.new(
        {
          id: '12334105',
          name: 'Shopin1901',
          created_at: '2010-12-10',
          updated_at: '2011-12-04'
        }, mock_merchant_repo)

      expect(merchant.id).to eq(12334105)
      expect(merchant.name).to eq('Shopin1901')
      expect(merchant.created_at.year).to eq(2010)
      expect(merchant.updated_at.year).to eq(2011)
    end
  end

  describe '#best_item' do
    it 'finds best items for merchant in terms of revenue generated' do
      se = SalesEngine.from_csv(
        items: './data/items.csv',
        merchants: './data/merchants.csv',
        invoices: './data/invoices.csv',
        customers: './data/customers.csv',
        invoice_items: './data/invoice_items.csv',
        transactions: './data/transactions.csv'
                              )
      merchant = se.find_merchant_by_id(12335311)

      expect(merchant.best_item).to be_a(Item)
      expect(merchant.best_item.id).to eq(263431293)
    end
  end

  describe '#update_name' do
    it 'updates name with givin attributes' do
      mock_merchant_repo = instance_double('MerchantRepository')
      merchant = Merchant.new(
        {
          id: '12334105',
          name: 'Shopin1901',
          created_at: '2010-12-10',
          updated_at: '2011-12-04'
        }, mock_merchant_repo)

      expect(merchant.name).to eq('Shopin1901')
      merchant.update(name: 'Jimmy')
      expect(merchant.name).to eq('Jimmy')
    end
  end

  describe '#update_time_stamp' do
    it 'can update updated_at time stamp' do
      mock_merchant_repo = instance_double('MerchantRepository')
      merchant = Merchant.new(
        {
          id: '12334105',
          name: 'Shopin1901',
          created_at: '2010-12-10',
          updated_at: '2011-12-04'
        }, mock_merchant_repo)

      expect(merchant.updated_at.year).to eq(2011)
      merchant.update_time_stamp
      expect(merchant.updated_at.year).to eq(2021)
    end
  end

  describe '#update' do
    it 'can update the entire merchant object' do
      mock_merchant_repo = instance_double('MerchantRepository')
      merchant = Merchant.new(
        {
          id: '12334105',
          name: 'Shopin1901',
          created_at: '2010-12-10',
          updated_at: '2011-12-04'
        }, mock_merchant_repo)

      expect(merchant.name).to eq('Shopin1901')
      expect(merchant.updated_at.year).to eq(2011)
      merchant.update(name: 'Jimmy')
      expect(merchant.name).to eq('Jimmy')
      expect(merchant.updated_at.year).to eq(2021)
    end
  end

  describe '#items' do
    it 'returns merchants items' do
      se = SalesEngine.from_csv(
        items: './data/items.csv',
        merchants: './data/merchants.csv',
        invoices: './data/invoices.csv',
        customers: './data/customers.csv',
        invoice_items: './data/invoice_items.csv',
        transactions: './data/transactions.csv'
                              )
      mr = MerchantRepository.new('./data/merchants.csv', se)
      merchant = Merchant.new(
        {
          id: '12334105',
          name: 'Shopin1901',
          created_at: '2010-12-10',
          updated_at: '2011-12-04'
        }, mr)

      expect(merchant.items[0]).to be_a(Item)
      expect(merchant.items.count).to eq(3)
    end
  end

  describe '#items_count' do
    it 'can count the amount of items a merchant has' do
      se = SalesEngine.from_csv(
        items: './data/items.csv',
        merchants: './data/merchants.csv',
        invoices: './data/invoices.csv',
        customers: './data/customers.csv',
        invoice_items: './data/invoice_items.csv',
        transactions: './data/transactions.csv'
                              )
      mr = MerchantRepository.new('./data/merchants.csv', se)
      merchant = Merchant.new(
        {
          id: '12334105',
          name: 'Shopin1901',
          created_at: '2010-12-10',
          updated_at: '2011-12-04'
        }, mr)

      expect(merchant.items_count).to eq(3)
    end
  end

  describe '#invoices' do
    it 'returns the merchants invoices' do
      se = SalesEngine.from_csv(
        items: './data/items.csv',
        merchants: './data/merchants.csv',
        invoices: './data/invoices.csv',
        customers: './data/customers.csv',
        invoice_items: './data/invoice_items.csv',
        transactions: './data/transactions.csv'
                              )
      mr = MerchantRepository.new('./data/merchants.csv', se)
      merchant = Merchant.new(
        {
          id: '12334105',
          name: 'Shopin1901',
          created_at: '2010-12-10',
          updated_at: '2011-12-04'
        }, mr)

      expect(merchant.invoices.count).to eq(10)
    end
  end

  describe '#invoices_count' do
    it 'can count the number of invoices' do
      se = SalesEngine.from_csv(
        items: './data/items.csv',
        merchants: './data/merchants.csv',
        invoices: './data/invoices.csv',
        customers: './data/customers.csv',
        invoice_items: './data/invoice_items.csv',
        transactions: './data/transactions.csv'
                              )
      mr = MerchantRepository.new('./data/merchants.csv', se)
      merchant = Merchant.new(
        {
          id: '12334105',
          name: 'Shopin1901',
          created_at: '2010-12-10',
          updated_at: '2011-12-04'
        }, mr)

      expect(merchant.invoices_count).to eq(10)
    end
  end

  describe '#sold_items_quantity_hash' do
    it 'returns a hash with item and quantity' do
      se = SalesEngine.from_csv(
        items: './data/items.csv',
        merchants: './data/merchants.csv',
        invoices: './data/invoices.csv',
        customers: './data/customers.csv',
        invoice_items: './data/invoice_items.csv',
        transactions: './data/transactions.csv'
                              )
      mr = MerchantRepository.new('./data/merchants.csv', se)
      merchant = Merchant.new(
        {
          id: '12334105',
          name: 'Shopin1901',
          created_at: '2010-12-10',
          updated_at: '2011-12-04'
        }, mr)

      expect(merchant.sold_items_quantity_hash).to be_a(Hash)
    end
  end

  describe '#pending_invoices?' do
    it 'checks if merchant has pending invoices' do
      se = SalesEngine.from_csv(
        items: './data/items.csv',
        merchants: './data/merchants.csv',
        invoices: './data/invoices.csv',
        customers: './data/customers.csv',
        invoice_items: './data/invoice_items.csv',
        transactions: './data/transactions.csv'
                              )
      mr = MerchantRepository.new('./data/merchants.csv', se)
      merchant = Merchant.new(
        {
          id: '12334105',
          name: 'Shopin1901',
          created_at: '2010-12-10',
          updated_at: '2011-12-04'
        }, mr)
    expect(merchant.pending_invoices?).to eq(true)
    end
  end

   describe '#sold_items_revenue_hash' do
    it 'returns a hash with items sold and their revenue' do
      se = SalesEngine.from_csv(
        items: './data/items.csv',
        merchants: './data/merchants.csv',
        invoices: './data/invoices.csv',
        customers: './data/customers.csv',
        invoice_items: './data/invoice_items.csv',
        transactions: './data/transactions.csv'
                              )
      mr = MerchantRepository.new('./data/merchants.csv', se)
      merchant = Merchant.new(
        {
          id: '12334105',
          name: 'Shopin1901',
          created_at: '2010-12-10',
          updated_at: '2011-12-04'
        }, mr)

      expect(merchant.sold_items_revenue_hash).to be_a(Hash)
      expect(merchant.sold_items_revenue_hash[263506360]).to eq(879.09)
    end
  end

  describe '#best_item' do
    it 'finds the item with the most revenue' do
      se = SalesEngine.from_csv(
        items: './data/items.csv',
        merchants: './data/merchants.csv',
        invoices: './data/invoices.csv',
        customers: './data/customers.csv',
        invoice_items: './data/invoice_items.csv',
        transactions: './data/transactions.csv'
                              )
      mr = MerchantRepository.new('./data/merchants.csv', se)
      merchant = Merchant.new(
        {
          id: '12334105',
          name: 'Shopin1901',
          created_at: '2010-12-10',
          updated_at: '2011-12-04'
        }, mr)

      expect(merchant.best_item.id).to eq(263561102)
    end
  end

  describe '#average_item_price' do
    it 'returns the average item price' do
      se = SalesEngine.from_csv(
        items: './data/items.csv',
        merchants: './data/merchants.csv',
        invoices: './data/invoices.csv',
        customers: './data/customers.csv',
        invoice_items: './data/invoice_items.csv',
        transactions: './data/transactions.csv'
                              )
      mr = MerchantRepository.new('./data/merchants.csv', se)
      merchant = Merchant.new(
        {
          id: '12334105',
          name: 'Shopin1901',
          created_at: '2010-12-10',
          updated_at: '2011-12-04'
        }, mr)

      expect(merchant.average_item_price).to eq(0.1666e2)
    end
  end

  describe '#item_price_hash' do
    it 'returns a hash with the item and its price' do
      se = SalesEngine.from_csv(
        items: './data/items.csv',
        merchants: './data/merchants.csv',
        invoices: './data/invoices.csv',
        customers: './data/customers.csv',
        invoice_items: './data/invoice_items.csv',
        transactions: './data/transactions.csv'
                              )
      mr = MerchantRepository.new('./data/merchants.csv', se)
      merchant = Merchant.new(
        {
          id: '12334105',
          name: 'Shopin1901',
          created_at: '2010-12-10',
          updated_at: '2011-12-04'
        }, mr)

      expect(merchant.item_price_hash).to eq(263396209=>0.2999e2,
                                             263500440=>0.999e1,
                                             263501394=>0.999e1)
    end
  end

  describe '#most_sold_item' do
    it 'returns the item that sold the most' do
      se = SalesEngine.from_csv(
        items: './data/items.csv',
        merchants: './data/merchants.csv',
        invoices: './data/invoices.csv',
        customers: './data/customers.csv',
        invoice_items: './data/invoice_items.csv',
        transactions: './data/transactions.csv'
                              )
      mr = MerchantRepository.new('./data/merchants.csv', se)
      merchant = Merchant.new(
        {
          id: '12334105',
          name: 'Shopin1901',
          created_at: '2010-12-10',
          updated_at: '2011-12-04'
        }, mr)

      expect(merchant.most_sold_item[0]).to be_a(Item)
    end
  end

  describe '#successful_invoices' do
    it 'returns the merchants successful invoices' do
      se = SalesEngine.from_csv(
        items: './data/items.csv',
        merchants: './data/merchants.csv',
        invoices: './data/invoices.csv',
        customers: './data/customers.csv',
        invoice_items: './data/invoice_items.csv',
        transactions: './data/transactions.csv'
                              )
      mr = MerchantRepository.new('./data/merchants.csv', se)
      merchant = Merchant.new(
        {
          id: '12334105',
          name: 'Shopin1901',
          created_at: '2010-12-10',
          updated_at: '2011-12-04'
        }, mr)

      expect(merchant.successful_invoices).to eq([74, 139, 1195, 3248, 3485])
    end
  end

  describe '#total_revenue' do
    it 'returns the merchants total revenue' do
      se = SalesEngine.from_csv(
        items: './data/items.csv',
        merchants: './data/merchants.csv',
        invoices: './data/invoices.csv',
        customers: './data/customers.csv',
        invoice_items: './data/invoice_items.csv',
        transactions: './data/transactions.csv'
                              )
      mr = MerchantRepository.new('./data/merchants.csv', se)
      merchant = Merchant.new(
        {
          id: '12334105',
          name: 'Shopin1901',
          created_at: '2010-12-10',
          updated_at: '2011-12-04'
        }, mr)

      expect(merchant.total_revenue).to eq(73777.17)
    end
  end
end