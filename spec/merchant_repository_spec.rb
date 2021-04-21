require 'simplecov'
SimpleCov.start
require './lib/sales_engine'
require './lib/merchant_repository'
require './lib/item_repository'


RSpec.describe MerchantRepository do
  describe '#initialize' do
    it 'exists' do
      mock_sales_engine = instance_double('SalesEngine')
      truncated_merchants = './spec/truncated_data/merchants_truncated.csv'
      mr = MerchantRepository.new(truncated_merchants, mock_sales_engine)

      expect(mr).to be_instance_of(MerchantRepository)
    end

    it 'has merchants' do
      mock_sales_engine = instance_double('SalesEngine')
      truncated_merchants = './spec/truncated_data/merchants_truncated.csv'
      mr = MerchantRepository.new(truncated_merchants, mock_sales_engine)

      expect(mr.merchants[0]).to be_a(Merchant)
    end
  end

  describe '#all' do
    it 'returns all merchants' do
      mock_sales_engine = instance_double('SalesEngine')
      truncated_merchants = './spec/truncated_data/merchants_truncated.csv'
      mr = MerchantRepository.new(truncated_merchants, mock_sales_engine)

      expect(mr.all).to be_a(Array)
      expect(mr.all.count).to eq(4)
      expect(mr.all[0]).to be_a(Merchant)
    end
  end

  describe '#average_average_price_per_merchant' do
    it 'sum the averages and finds average price across all merchants' do
      mock_sales_engine = instance_double('SalesEngine')
      ir = ItemRepository.new('spec/truncated_data/items_truncated.csv', mock_sales_engine)

      expect(ir.average_average_price_per_merchant).to eq(0.1862e2)
    end
  end

  # describe '#average_items_per_merchant' do
  #   it 'can find the average number of items per merchant' do
  #     mock_sales_engine = instance_double('SalesEngine')
  #     ir = ItemRepository.new('spec/truncated_data/items_truncated.csv', mock_sales_engine)

  #     expect(ir.average_items_per_merchant).to eq(1.25)
  #   end
  # end

  # describe '#average_items_per_merchant_standard_deviation' do
  #   it 'can find the average item per merchant standard deviation' do
  #     mock_sales_engine = instance_double('SalesEngine')
  #     ir = ItemRepository.new('spec/truncated_data/items_truncated.csv', mock_sales_engine)

  #     expect(ir.average_items_per_merchant_standard_deviation).to eq(0.5)
  #   end
  # end

  # describe '#average_item_price_for_merchant' do
  #   it 'averages the item price for merchant' do
  #     mock_sales_engine = instance_double('SalesEngine')
  #     ir = ItemRepository.new('spec/truncated_data/items_truncated.csv', mock_sales_engine)

  #     expect(ir.average_item_price_for_merchant(12334105)).to eq(14)
  #   end
  # end

  # describe '#average_invoices_per_merchant' do
  #   it 'shows average number of invoices by merchant' do
  #     mock_sales_engine = instance_double('SalesEngine')
  #     ir = InvoiceRepository.new('./data/invoices.csv', mock_sales_engine)

  #     expect(ir.average_invoices_per_merchant).to eq(10.49)
  #   end
  # end

  # describe '#bottom_merchants_by_invoice_count' do
  #   it 'tells which merchants are more than two std deviation below the mean' do
  #     mock_sales_engine = instance_double('SalesEngine')
  #     mock_merchant_repo = instance_double('MerchantRepository')
  #     merchant = Merchant.new({
  #                               id: '1',
  #                               name: 'Shopin1901',
  #                               created_at: '2010-12-10',
  #                               updated_at: '2011-12-04'
  #                             }, mock_merchant_repo)
  #     allow(mock_sales_engine).to receive(:find_merchant_by_id) { merchant }
  #     ir = InvoiceRepository.new('./data/invoices.csv', mock_sales_engine)

  #     expect(ir.bottom_merchants_by_invoice_count.count).to eq(4)
  #     expect(ir.bottom_merchants_by_invoice_count.first).to be_a(Merchant)
  #   end
  # end

  describe '#create' do
    it 'can create new merchant' do
      mock_sales_engine = instance_double('SalesEngine')
      truncated_merchants = './spec/truncated_data/merchants_truncated.csv'
      mr = MerchantRepository.new(truncated_merchants, mock_sales_engine)
      mr.create({
                  name: 'JimmysSubs',
                  created_at: Time.now.to_s,
                  updated_at: Time.now.to_s
                })

      expect(mr.find_by_id(12334114)).to eq(mr.merchants[4])
    end
  end

  describe '#delete' do
    it 'can delete merchant object' do
      mock_sales_engine = instance_double('SalesEngine')
      truncated_merchants = './spec/truncated_data/merchants_truncated.csv'
      mr = MerchantRepository.new(truncated_merchants, mock_sales_engine)

      mr.delete(12334105)

      expect(mr.find_by_id(12334105)).to eq(nil)
    end
  end

  describe '#find_all_by_name' do
    it 'finds all names containing fragment or empty array' do
      mock_sales_engine = instance_double('SalesEngine')
      truncated_merchants = './spec/truncated_data/merchants_truncated.csv'
      mr = MerchantRepository.new(truncated_merchants, mock_sales_engine)

      expect(mr.find_all_by_name('Rtpdsfsd')).to eq([])
      expect(mr.find_all_by_name('Can')).to eq([mr.merchants[1]])
      expect(mr.find_all_by_name('Min')).to eq([mr.merchants[2], mr.merchants[3]])
    end
  end

  describe '#find_by_id' do
    it 'finds by id or returns nil' do
      mock_sales_engine = instance_double('SalesEngine')
      truncated_merchants = './spec/truncated_data/merchants_truncated.csv'
      mr = MerchantRepository.new(truncated_merchants, mock_sales_engine)

      expect(mr.find_by_id(3)).to eq(nil)
      expect(mr.find_by_id(12334105)).to eq(mr.merchants[0])
    end
  end

  describe '#find_by_name' do
    it 'finds by name or returns nil' do
      mock_sales_engine = instance_double('SalesEngine')
      truncated_merchants = './spec/truncated_data/merchants_truncated.csv'
      mr = MerchantRepository.new(truncated_merchants, mock_sales_engine)

      expect(mr.find_by_name('JimmysSubs')).to eq(nil)
      expect(mr.find_by_name('Shopin1901')).to eq(mr.merchants[0])
    end
  end

  # describe '#items_per_merchant' do
  #   it 'creates a hash of merchant id keys and an item count for values' do
  #     mock_sales_engine = instance_double('SalesEngine')
  #     ir = ItemRepository.new('spec/truncated_data/items_truncated.csv', mock_sales_engine)

  #     hash = {
  #             12334105 => 2,
  #             12345678 => 1,
  #             12334113 => 1,
  #             12333333 => 1
  #             }

  #     expect(ir.items_per_merchant).to eq(hash)
  #   end
  # end

  # describe '#invoices_per_merchant' do
  #   it 'shows invoices by merchant' do
  #     mock_sales_engine = instance_double('SalesEngine')
  #     ir = InvoiceRepository.new('./data/invoices.csv', mock_sales_engine)

  #     expect(ir.invoices_per_merchant.keys.count).to eq(475)
  #   end
  # end

  describe '#merchants_created_in_month' do
    it 'returns all merchants created in the month given' do
      mock_sales_engine = instance_double('SalesEngine')
      truncated_merchants = './spec/truncated_data/merchants_truncated.csv'
      mr = MerchantRepository.new(truncated_merchants, mock_sales_engine)

      expect(mr.merchants_created_in_month('March').count).to eq(1)
    end
  end

  # describe '#merchants_with_pending_invoices' do
  #   it 'returns merchants with pending invoices' do
  #     se = SalesEngine.from_csv({
  #                                 items: './spec/truncated_data/items_truncated.csv',
  #                                 merchants: './spec/truncated_data/merchants_truncated.csv',
  #                                 invoices: './spec/truncated_data/invoices_truncated.csv',
  #                                 customers: './spec/truncated_data/customers_truncated.csv',
  #                                 invoice_items: './spec/truncated_data/invoice_items_truncated.csv',
  #                                 transactions: './spec/truncated_data/transactions_truncated.csv'
  #                               })
  #     sales_analyst = se.analyst

  #     ir = InvoiceRepository.new('./data/invoices.csv', se)

  #     expect(ir.merchants_with_pending_invoices.count).to eq(4)
  #   end
  # end

  describe '#merchants_with_only_one_item_registered_in_month' do
    it 'can return all merchants with only one item the month registered' do
      se = SalesEngine.from_csv(
        items: './data/items.csv',
        merchants: './data/merchants.csv',
        invoices: './data/invoices.csv',
        customers: './data/customers.csv',
        invoice_items: './data/invoice_items.csv',
        transactions: './data/transactions.csv'
                               )
      mr = MerchantRepository.new('./data/merchants.csv', se)
      expected = mr.merchants_with_only_one_item_registered_in_month('March').count

      expect(expected).to eq(21)
    end
  end

  # describe '#merchants_with_high_item_count' do
  #   it 'can find which merchants sell the most items' do
  #     se = SalesEngine.from_csv(
  #         items: './spec/truncated_data/items_truncated.csv',
  #         merchants: './spec/truncated_data/merchants_truncated.csv',
  #         invoices: './spec/truncated_data/invoices_truncated.csv',
  #         customers: './spec/truncated_data/customers_truncated.csv',
  #         invoice_items: './spec/truncated_data/invoice_items_truncated.csv',
  #         transactions: './spec/truncated_data/transactions_truncated.csv'
  #                              )
  #     ir = ItemRepository.new('spec/truncated_data/items_truncated.csv', se)
  #     mr = MerchantRepository.new('./spec/truncated_data/merchants_truncated.csv', se)

  #     expect(ir.merchants_with_high_item_count[0].name).to eq("Shopin1901")
  #   end
  # end

  # describe '#merchants_with_only_one_item' do
  #   it 'finds merchants with only 1 item and returns item object' do
  #     se = SalesEngine.from_csv(
  #       items: './spec/truncated_data/items_truncated.csv',
  #       merchants: './spec/truncated_data/merchants_truncated.csv',
  #       invoices: './spec/truncated_data/invoices_truncated.csv',
  #       customers: './spec/truncated_data/customers_truncated.csv',
  #       invoice_items: './spec/truncated_data/invoice_items_truncated.csv',
  #       transactions: './spec/truncated_data/transactions_truncated.csv'
  #                              )
  #     ir = ItemRepository.new('spec/truncated_data/items_truncated.csv', se)

  #     expect(ir.merchants_with_only_one_item.count).to eq(3)
  #     expect(ir.merchants_with_only_one_item[1].name).to eq('MiniatureBikez')
  #   end
  # end

  # describe '#revenue_by_merchant' do
  #   it 'returns the total revenue for given merchant' do
  #     se = SalesEngine.from_csv({
  #                                 items: './spec/truncated_data/items_truncated.csv',
  #                                 merchants: './spec/truncated_data/merchants_truncated.csv',
  #                                 invoices: './data/invoices.csv',
  #                                 customers: './spec/truncated_data/customers_truncated.csv',
  #                                 invoice_items: './data/invoice_items.csv',
  #                                 transactions: './data/transactions.csv'
  #                               })
  #     ir = InvoiceRepository.new('./data/invoices.csv', se)

  #     expect(ir.revenue_by_merchant(12334105)).to eq(73777.17)
  #   end
  # end

  # describe '#stdev_invoices_per_merchant' do
  #   it 'shows standard deviation of invoices by merchant' do
  #     mock_sales_engine = instance_double('SalesEngine')
  #     ir = InvoiceRepository.new('./data/invoices.csv', mock_sales_engine)

  #     expect(ir.stdev_invoices_per_merchant).to eq(3.29)
  #   end
  # end

  describe '#top_buyers' do
    it 'returns the top buyers' do
      se = SalesEngine.from_csv({
                                  items: './data/items.csv',
                                  merchants: './data/merchants.csv',
                                  invoices: './data/invoices.csv',
                                  customers: './data/customers.csv',
                                  invoice_items: './data/invoice_items.csv',
                                  transactions: './data/transactions.csv'
                                })
      ir = InvoiceRepository.new('./data/invoices.csv', se)
      iir = InvoiceItemRepository.new('./data/invoice_items.csv', se)
      mr = MerchantRepository.new('./data/merchants.csv', se)

      expect(ir.top_buyers(1)[0]).to be_a(Customer)
      expect(ir.top_buyers(1).count).to eq(1)
    end
  end

  # describe '#top_merchants_by_invoice_count' do
  #   it 'tells which merchants are more than two std deviation above the mean' do
  #     mock_sales_engine = instance_double('SalesEngine')
  #     mock_merchant_repo = instance_double('MerchantRepository')
  #     merchant = Merchant.new({
  #                               id: '1',
  #                               name: 'Shopin1901',
  #                               created_at: '2010-12-10',
  #                               updated_at: '2011-12-04'
  #                             }, mock_merchant_repo)
  #     allow(mock_sales_engine).to receive(:find_merchant_by_id) { merchant }
  #     ir = InvoiceRepository.new('./data/invoices.csv', mock_sales_engine)

  #     expect(ir.top_merchants_by_invoice_count.count).to eq(12)
  #     expect(ir.top_merchants_by_invoice_count.first).to be_a(Merchant)
  #   end
  # end

  # describe '#top_revenue_earners' do
  #   it 'returns the top revenue earners' do
  #     se = SalesEngine.from_csv({
  #                                 items: './data/items.csv',
  #                                 merchants: './data/merchants.csv',
  #                                 invoices: './data/invoices.csv',
  #                                 customers: './data/customers.csv',
  #                                 invoice_items: './data/invoice_items.csv',
  #                                 transactions: './data/transactions.csv'
  #                               })
  #     ir = InvoiceRepository.new('./data/invoices.csv', se)
  #     iir = InvoiceItemRepository.new('./data/invoice_items.csv', se)
  #     mr = MerchantRepository.new('./data/merchants.csv', se)

  #     expect(mr.top_revenue_earners(1)[0]).to be_a(Merchant)
  #     expect(mr.top_revenue_earners(1).count).to eq(1)
  #   end
  # end

  # describe '#total_revenue_by_merchant' do
  #   it 'creates an array of unique merchant id\'s and their total revenue' do
  #     sales_engine = SalesEngine.from_csv({
  #                                           items: './data/items.csv',
  #                                           merchants: './data/merchants.csv',
  #                                           invoices: './data/invoices.csv',
  #                                           customers: './data/customers.csv',
  #                                           invoice_items: './data/invoice_items.csv',
  #                                           transactions: './data/transactions.csv'
  #                                        })
  #     ir = InvoiceRepository.new('./data/invoices.csv', sales_engine)
  #     iir = InvoiceItemRepository.new('./data/invoice_items.csv', sales_engine)

  #     expect(ir.total_revenue_by_merchant.count).to eq(950)
  #   end
  # end

  describe '#update' do
    it 'can update merchants name' do
      mock_sales_engine = instance_double('SalesEngine')
      truncated_merchants = './spec/truncated_data/merchants_truncated.csv'
      mr = MerchantRepository.new(truncated_merchants, mock_sales_engine)

      mr.update(12334105, {name: 'ShopinShopinShopin'})

      expect(mr.merchants[0].name).to eq('ShopinShopinShopin')
      expect(mr.find_by_name('Shopin1901')).to eq(nil)
    end
  end
end
