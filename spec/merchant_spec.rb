require 'rspec'
require './lib/merchant'

describe Merchant do

  describe '#initialize' do
    it 'is an intance of Merchant class' do
      merch_hash = {id: 7, name: 'Turing School'}
      m = Merchant.new(merch_hash)

      expect(m).to be_an_instance_of(Merchant)
    end

    it 'has readable attributes' do
      merch_hash = {id: 7, name: 'Turing School'}
      m = Merchant.new(merch_hash)

      expect(m.id).to eq(7)
      expect(m.name).to eq('Turing School')
      expect(m.total_revenue).to eq(0)
    end
  end

  describe '#update_info' do
    it 'can update a merchant name' do
      merch_hash = {id: 7, name: 'Turing School'}
      m = Merchant.new(merch_hash)
      attributes = {
        name: 'Hogwarts School of Witchcraft and Wizardry',
        id: 26
      }

      m.update_info(attributes)

      expect(m.id).to eq(7)
      expect(m.name).to eq('Hogwarts School of Witchcraft and Wizardry')
    end
  end
end
