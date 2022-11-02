require 'rspec'
require 'csv'
require './lib/merchant_repository'

describe MerchantRepository do
  let(:mr) { MerchantRepository.new }
  let(:data) { CSV.open './data/merchants_test.csv', headers: true, header_converters: :symbol }

  describe '#initialize' do
    it 'is and instance of MerchantRepository' do
      expect(mr).to be_a MerchantRepository
    end

    it 'can store an array of merchants' do
      expect(mr.repository).to eq([])
    end
  end

  describe '#create' do
    it 'creates a Merchant and adds object to @merchants' do
      data.each { |line| mr.create(line) }

      expect(mr.repository[0].id).to eq('12334105')
      expect(mr.repository[1].id).to eq('12334112')
      expect(mr.repository[2].id).to eq('12334113')
      expect(mr.repository[3].id).to eq('12334115')
      expect(mr.repository[0].name).to eq('Shopin1901')
      expect(mr.repository[1].name).to eq('Candisart')
      expect(mr.repository[2].name).to eq('MiniatureBikez')
      expect(mr.repository[3].name).to eq('LolaMarleys')
    end
  end

  describe '#all' do
    it 'returns an array of all known Merchant instances' do
      data.each { |line| mr.create(line) }

      expect(mr.all).to be_a Array
      expect(mr.all).to eq(mr.repository)
    end
  end

  describe '#find_by_id' do
    it 'returns nil or a Merchant instance that matches id' do
      data.each { |line| mr.create(line) }

      expect(mr.find_by_id('12334112')).to eq(mr.repository[1])
      expect(mr.find_by_id('2')).to be nil
    end
  end

  describe '#find_by_name' do
    it 'returns nil or a Merchant instance that matches by name regardless of case' do
      data.each { |line| mr.create(line) }

      expect(mr.find_by_name('shopin1901')).to eq(mr.repository[0])
      expect(mr.find_by_name('nadda')).to be nil
    end
  end

  describe '#find_all_by_name' do
    it 'returns an array of all Merchant instances that include the argument' do
      data.each { |line| mr.create(line) }

      expect(mr.find_all_by_name('s')).to eq([mr.repository[0], mr.repository[1], mr.repository[3]])
      expect(mr.find_all_by_name('test')).to eq([])
      expect(mr.find_all_by_name('SHOP')).to eq([mr.repository[0]])
    end
  end

  describe '#update' do
    it 'updates the Merchant instance that matches the id with the provided name' do
      data.each { |line| mr.create(line) }
      mr.update('12334115', 'UpdatedMarleys')

      expect(mr.find_by_id('12334115').name).to eq('UpdatedMarleys')
    end
  end

  describe '#delete' do
    it 'removes a Merchant instance with the corresponding id' do
      data.each { |line| mr.create(line) }
      mr.delete('12334113')

      expect(mr.repository.count).to eq(3)
      expect(mr.repository[2].id).to eq('12334115')
    end
  end
end
