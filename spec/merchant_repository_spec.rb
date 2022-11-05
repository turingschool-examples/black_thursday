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
end
