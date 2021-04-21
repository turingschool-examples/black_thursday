# require 'simplecov'
# SimpleCov.start
require './lib/sales_engine'
require './lib/merchant_repository'

RSpec.describe Merchant do
  describe '#initialize' do
    it 'exists' do
      mock_merchant_repo = instance_double('MerchantRepository')
      merchant = Merchant.new({
                                id: '12334105',
                                name: 'Shopin1901',
                                created_at: '2010-12-10',
                                updated_at: '2011-12-04'
                              }, mock_merchant_repo)

      expect(merchant).to be_a(Merchant)
    end

    it 'has attributes' do
      mock_merchant_repo = instance_double('MerchantRepository')
      merchant = Merchant.new({
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
      se = SalesEngine.from_csv({
                                  items: './data/items.csv',
                                  merchants: './data/merchants.csv',
                                  invoices: './data/invoices.csv',
                                  customers: './data/customers.csv',
                                  invoice_items: './data/invoice_items.csv',
                                  transactions: './data/transactions.csv'
                                  })
      merchant = se.find_merchant_by_id(12335311)

      expect(merchant.best_item).to be_a(Item)
      expect(merchant.best_item.id).to eq(263431293)
    end
  end

  describe '#update_name' do
    it 'updates name with givin attributes' do
      mock_merchant_repo = instance_double('MerchantRepository')
      merchant = Merchant.new({
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
      merchant = Merchant.new({
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
      merchant = Merchant.new({
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

  describe '#merchant_items' do
    xit 'has items' do
      se = SalesEngine.from_csv({
        items: './data/items.csv',
        merchants: './data/merchants.csv',
        invoices: './data/invoices.csv',
        customers: './data/customers.csv',
        invoice_items: './data/invoice_items.csv',
        transactions: './data/transactions.csv'
                                })
      mr = MerchantRepository.new('./data/merchants.csv', se)
      merchant = Merchant.new({
                              id: '12334105',
                              name: 'Shopin1901',
                              created_at: '2010-12-10',
                              updated_at: '2011-12-04'
                            }, mr)

      expect(merchant.merchant_items[0]).to be_a(Item)
      expect(merchant.merchant_items.count).to eq(3)
    end
  end

  describe '#items_count' do
    xit 'can count the amount of items a merchant has' do
      se = SalesEngine.from_csv({
        items: './data/items.csv',
        merchants: './data/merchants.csv',
        invoices: './data/invoices.csv',
        customers: './data/customers.csv',
        invoice_items: './data/invoice_items.csv',
        transactions: './data/transactions.csv'
                                })
      mr = MerchantRepository.new('./data/merchants.csv', se)
      merchant = Merchant.new({
                              id: '12334105',
                              name: 'Shopin1901',
                              created_at: '2010-12-10',
                              updated_at: '2011-12-04'
                            }, mr)
        merchant.items_quantity_hash
      expect(merchant.items_count).to eq(3)
    end
  end

  describe '#invoice_ids' do
    xit 'can list invoice ids' do
      se = SalesEngine.from_csv({
        items: './data/items.csv',
        merchants: './data/merchants.csv',
        invoices: './data/invoices.csv',
        customers: './data/customers.csv',
        invoice_items: './data/invoice_items.csv',
        transactions: './data/transactions.csv'
                                })
      mr = MerchantRepository.new('./data/merchants.csv', se)
      merchant = Merchant.new({
                              id: '12334105',
                              name: 'Shopin1901',
                              created_at: '2010-12-10',
                              updated_at: '2011-12-04'
                            }, mr)

      expect(merchant.merchant_invoices.count).to eq(10)
    end
  end

  describe '#sold_items_quantity_hash' do
    it 'returns a hash with item and quantity' do
      se = SalesEngine.from_csv({
      items: './data/items.csv',
      merchants: './data/merchants.csv',
      invoices: './data/invoices.csv',
      customers: './data/customers.csv',
      invoice_items: './data/invoice_items.csv',
      transactions: './data/transactions.csv'
                              })
      mr = MerchantRepository.new('./data/merchants.csv', se)
      merchant = Merchant.new({
                              id: '12334105',
                              name: 'Shopin1901',
                              created_at: '2010-12-10',
                              updated_at: '2011-12-04'
                            }, mr)

      expect(merchant.sold_items_quantity_hash).to be_a(Hash)
    end
  end

  describe '#merchants_with_pending_invoices' do
    xit 'returns list of merchants with pending invoices' do
      se = SalesEngine.from_csv({
        items: './data/items.csv',
        merchants: './data/merchants.csv',
        invoices: './data/invoices.csv',
        customers: './data/customers.csv',
        invoice_items: './data/invoice_items.csv',
        transactions: './data/transactions.csv'
                                })
      mr = MerchantRepository.new('./data/merchants.csv', se)
      merchant = Merchant.new({
                              id: '12334105',
                              name: 'Shopin1901',
                              created_at: '2010-12-10',
                              updated_at: '2011-12-04'
                            }, mr)
    expect(merchant.merchants_with_pending_invoices.count).to eq(4)
    end
  end

   describe '#items_revenue_hash' do
    xit 'returns a hash with item and revenue' do
      se = SalesEngine.from_csv({
      items: './data/items.csv',
      merchants: './data/merchants.csv',
      invoices: './data/invoices.csv',
      customers: './data/customers.csv',
      invoice_items: './data/invoice_items.csv',
      transactions: './data/transactions.csv'
                              })
      mr = MerchantRepository.new('./data/merchants.csv', se)
      merchant = Merchant.new({
                              id: '12334105',
                              name: 'Shopin1901',
                              created_at: '2010-12-10',
                              updated_at: '2011-12-04'
                            }, mr)

      expect(merchant.items_revenue_hash).to be_a(Hash)
    end
  end

  describe '#best_item' do
    xit 'finds the item with the most revenue' do
      se = SalesEngine.from_csv({
      items: './data/items.csv',
      merchants: './data/merchants.csv',
      invoices: './data/invoices.csv',
      customers: './data/customers.csv',
      invoice_items: './data/invoice_items.csv',
      transactions: './data/transactions.csv'
                              })
      mr = MerchantRepository.new('./data/merchants.csv', se)
      merchant = Merchant.new({
                              id: '12334105',
                              name: 'Shopin1901',
                              created_at: '2010-12-10',
                              updated_at: '2011-12-04'
                            }, mr)

      expect(merchant.best_item[0].id).to eq(263396209)
    end
  end

  describe '#average_item_price' do
    it 'returns the average item price' do
      se = SalesEngine.from_csv({
      items: './data/items.csv',
      merchants: './data/merchants.csv',
      invoices: './data/invoices.csv',
      customers: './data/customers.csv',
      invoice_items: './data/invoice_items.csv',
      transactions: './data/transactions.csv'
                              })
      mr = MerchantRepository.new('./data/merchants.csv', se)
      merchant = Merchant.new({
                              id: '12334105',
                              name: 'Shopin1901',
                              created_at: '2010-12-10',
                              updated_at: '2011-12-04'
                            }, mr)

      expect(merchant.average_item_price).to eq(2634.9)
    end
  end
end