require 'rspec'
require 'csv'
require './lib/merchant_repository'
require './lib/general_repo'

describe MerchantRepository do
  let(:data) { CSV.open './data/merchants_test.csv', headers: true, header_converters: :symbol }
  let(:mr) { MerchantRepository.new(data, "salesengine") }

  describe '#initialize' do
    it 'is and instance of MerchantRepository' do
      expect(mr).to be_a MerchantRepository
    end

    it 'can store an array of merchants' do
      m1 = mr.repository[0]
      m2 = mr.repository[1]
      m3 = mr.repository[2]
      m4 = mr.repository[3]
      expect(mr.repository).to eq([m1, m2, m3, m4])
    end
  end

  describe '#create' do
    it 'creates a Merchant and adds object to @merchants' do
      expect(mr.repository[0].id).to eq(12334105)
      expect(mr.repository[1].id).to eq(12334112)
      expect(mr.repository[2].id).to eq(12334113)
      expect(mr.repository[3].id).to eq(12334115)
      expect(mr.repository[0].name).to eq('Shopin1901')
      expect(mr.repository[1].name).to eq('Candisart')
      expect(mr.repository[2].name).to eq('MiniatureBikez')
      expect(mr.repository[3].name).to eq('LolaMarleys')
    end
  end

  describe '#all' do
    it 'returns an array of all known Merchant instances' do
      expect(mr.all).to be_a Array
      expect(mr.all).to eq(mr.repository)
    end
  end

  describe '#find_by_id' do
    it 'returns nil or a Merchant instance that matches id' do
      expect(mr.find_by_id(12334112)).to eq(mr.repository[1])
      expect(mr.find_by_id(2)).to be nil
    end
  end

  describe '#find_by_name' do
    it 'returns nil or a Merchant instance that matches by name regardless of case' do
      expect(mr.find_by_name('shopin1901')).to eq(mr.repository[0])
      expect(mr.find_by_name('nadda')).to be nil
    end
  end

  describe '#find_all_by_name' do
    it 'returns an array of all Merchant instances that include the argument' do
      expect(mr.find_all_by_name('s')).to eq([mr.repository[0], mr.repository[1], mr.repository[3]])
      expect(mr.find_all_by_name('test')).to eq([])
      expect(mr.find_all_by_name('SHOP')).to eq([mr.repository[0]])
    end
  end

  describe '#update' do
    it 'updates the Merchant instance that matches the id with the provided name' do
      mr.update(12334115, { name: 'UpdatedMarleys' })
      expect(mr.find_by_id(12334115).name).to eq('UpdatedMarleys')
    end
  end

  describe '#delete' do
    it 'removes a Merchant instance with the corresponding id' do
      mr.delete(12334113)
      expect(mr.repository.count).to eq(3)
      expect(mr.repository[2].id).to eq(12334115)
    end
  end

  describe '#number_of_items_per_merchant' do
    it 'returns the number of items per merchant' do
      engine = double('engine')
      items = double('item_repo')
      allow(mr).to receive(:engine).and_return(engine)
      allow(engine).to receive(:items).and_return(items)
      allow(items).to receive(:find_all_by_merchant_id).and_return(['item1', 'item2'])

      expect(mr.number_of_items_per_merchant).to eq [2, 2, 2, 2]
    end
  end

  describe '#items_per_merchant' do
    it 'returns a list of items per merchant' do
      allow(mr.all[0]).to receive(:_items).and_return(['item'])
      allow(mr.all[1]).to receive(:_items).and_return(['item1', 'item2'])
      allow(mr.all[2]).to receive(:_items).and_return(['item', 'item2', 'item3'])
      allow(mr.all[3]).to receive(:_items).and_return(['item'])

      expect(mr.items_per_merchant).to eq [['item'], ['item1', 'item2'], ['item', 'item2', 'item3'], ['item']]
    end
  end

  describe '#average_items_per_merchant' do
    it 'returns the average number of items per merchant' do
      allow(mr.all[0]).to receive(:_items).and_return(['item'])
      allow(mr.all[1]).to receive(:_items).and_return(['item1', 'item2'])
      allow(mr.all[2]).to receive(:_items).and_return(['item', 'item2', 'item3'])
      allow(mr.all[3]).to receive(:_items).and_return(['item'])

      expect(mr.average_items_per_merchant).to eq 1.75
    end
  end

  describe '#average_items_per_merchant_standard_deviation' do
    it 'returns the deviation for average number of items per mechant' do
      allow(mr.all[0]).to receive(:_items).and_return(['item'])
      allow(mr.all[1]).to receive(:_items).and_return(['item1', 'item2'])
      allow(mr.all[2]).to receive(:_items).and_return(['item', 'item2', 'item3'])
      allow(mr.all[3]).to receive(:_items).and_return(['item'])
      expect(mr.average_items_per_merchant_standard_deviation).to eq 0.96
    end
  end

  describe '#number_of_invoices_per_merchant' do
    it 'returns the number of invoices per merchant' do
      engine = double('engine')
      invoices = double('invoice_repo')
      allow(mr).to receive(:engine).and_return(engine)
      allow(engine).to receive(:invoices).and_return(invoices)
      allow(invoices).to receive(:find_all_by_merchant_id).and_return(['invoice1', 'invoice2'])

      expect(mr.number_of_invoices_per_merchant).to eq [2, 2, 2, 2]
    end
  end

  describe '#average_invoices_per_merchant' do
    it 'returns the average number of invoices per merchant' do
      allow(mr.all[0]).to receive(:_invoices).and_return(['invoice1'])
      allow(mr.all[1]).to receive(:_invoices).and_return(['invoice1', 'invoice2'])
      allow(mr.all[2]).to receive(:_invoices).and_return(['invoice1', 'invoice2', 'invoice3'])
      allow(mr.all[3]).to receive(:_invoices).and_return(['invoice1'])

      expect(mr.average_invoices_per_merchant).to eq 1.75
    end
  end

  describe '#average_invoice_per_merchant_standard_deviation' do
    it 'returns the deviation for average number of invoices per mechant' do
      allow(mr.all[0]).to receive(:_invoices).and_return(['invoice1'])
      allow(mr.all[1]).to receive(:_invoices).and_return(['invoice1', 'invoice2'])
      allow(mr.all[2]).to receive(:_invoices).and_return(['invoice1', 'invoice2', 'invoice3'])
      allow(mr.all[3]).to receive(:_invoices).and_return(['invoice1'])
      expect(mr.average_invoices_per_merchant_standard_deviation).to eq 0.96
    end
  end

  describe '#top_merchants_by_invoice_count' do
    it 'returns a collection of the merchants with a high deviation to the average' do
      engine = double('engine')
      invoices = double('invoice_repo')
      allow(mr).to receive(:engine).and_return(engine)
      allow(engine).to receive(:invoices).and_return(invoices)
      allow(mr.all[0]).to receive(:_invoices).and_return(['invoice1'])
      allow(mr.all[1]).to receive(:_invoices).and_return(['invoice1', 'invoice2'])
      allow(mr.all[2]).to receive(:_invoices).and_return(['invoice1', 'invoice2', 'invoice3'])
      allow(mr.all[3]).to receive(:_invoices).and_return(['invoice1'])

      expect(mr.top_merchants_by_invoice_count).to eq([])
    end
  end

  describe '#bottom_merchants_by_invoice_count' do
    it 'returns a collection of the merchants with a low deviation to the average' do
      engine = double('engine')
      invoices = double('invoice_repo')
      allow(mr).to receive(:engine).and_return(engine)
      allow(engine).to receive(:invoices).and_return(invoices)
      allow(mr.all[0]).to receive(:_invoices).and_return(['invoice1'])
      allow(mr.all[1]).to receive(:_invoices).and_return(['invoice1', 'invoice2'])
      allow(mr.all[2]).to receive(:_invoices).and_return(['invoice1', 'invoice2', 'invoice3'])
      allow(mr.all[3]).to receive(:_invoices).and_return(['invoice1'])

      expect(mr.top_merchants_by_invoice_count).to eq([])
    end
  end

  describe '#merchants_with_high_item_count' do
    it 'returns an array of merchants whos item count is greater than 1 standard deviation' do
      allow(mr.all[0]).to receive(:_items).and_return(['item'])
      allow(mr.all[1]).to receive(:_items).and_return(['item1', 'item2'])
      allow(mr.all[2]).to receive(:_items).and_return(['item', 'item2', 'item3', 'item4', 'item5', 'item6', 'item7'])
      allow(mr.all[3]).to receive(:_items).and_return(['item'])
      expect(mr.merchants_with_high_item_count).to eq([mr.all[2]])
    end
  end

  describe '#average_item_price_for_merchant' do
    it 'returns the average item price for the given merchant id' do
      allow(mr.all[0]).to receive(:avg_item_price).and_return(2.0)
      expect(mr.average_item_price_for_merchant(12_334_105)).to eq(2.0)
    end
  end

  describe '#average_average_price_per_merchant' do
    it 'returns the average of merchants average item price' do
      allow(mr.all[0]).to receive(:avg_item_price).and_return(1.0)
      allow(mr.all[1]).to receive(:avg_item_price).and_return(2.2)
      allow(mr.all[2]).to receive(:avg_item_price).and_return(3.6)
      allow(mr.all[3]).to receive(:avg_item_price).and_return(7.4)
      expect(mr.average_average_price_per_merchant).to eq 3.55
    end
  end

  describe '#top_revenue_earners' do
    it 'returns an array of x merchants ranked by revenue' do
      allow(mr.all[0]).to receive(:revenue).and_return(30000)
      allow(mr.all[1]).to receive(:revenue).and_return(5000)
      allow(mr.all[2]).to receive(:revenue).and_return(60000)
      allow(mr.all[3]).to receive(:revenue).and_return(25000)
      m1 = mr.repository[0]
      m2 = mr.repository[1]
      m3 = mr.repository[2]
      m4 = mr.repository[3]

      expect(mr.top_revenue_earners(2)).to eq([m3, m1])
      expect(mr.top_revenue_earners(3)).to eq([m3, m1, m4])
    end
  end
end
