require './lib/item'
require 'bigdecimal'
require 'RSpec'

RSpec.describe Item do
  describe '#initialize' do
    i = Item.new(
      id: 1,
      name: 'Pencil',
      description: 'You can use it to write things',
      cent_price: 1099,
      created_at: Time.now.to_s,
      updated_at: Time.now.to_s,
      merchant_id: 2,
      repository: 'repository'
    )
    it 'exists' do
      expect(i).to be_an_instance_of(Item)
    end
  end
  describe 'instance variables' do
    i = Item.new(
      id: 1,
      name: 'Pencil',
      description: 'You can use it to write things',
      cent_price: 1099,
      created_at: Time.now.to_s,
      updated_at: Time.now.to_s,
      merchant_id: 2,
      repository: 'repository'
    )
    it 'has an id' do
      expect(i.id).to eq(1)
    end
    it 'has a name' do
      expect(i.name).to eq('Pencil')
    end
    it 'has a description' do
      expect(i.description).to eq('You can use it to write things')
    end
    it 'has a unit price' do
      expect(i.unit_price).to eq(10.99)
    end
    it 'has a cent_price' do
      expect(i.cent_price).to eq(1099)
    end
    it 'has a merchant id' do
      expect(i.merchant_id).to eq(2)
    end
    it 'has a repository' do
      expect(i.repository).to eq('repository')
    end
  end
  describe 'instances of time' do
    it 'has a time created' do
      allow(Time).to receive(:now) do
        '12:58'
      end
      i = Item.new(
        id: 1,
        name: 'Pencil',
        description: 'You can use it to write things',
        cent_price: 1099,
        created_at: Time.now.to_s,
        updated_at: Time.now.to_s,
        merchant_id: 2,
        repository: 'repository'
      )
      expect(i.created_at).to eq('12:58')
    end
    it 'has a time updated' do
      allow(Time).to receive(:now) do
        '12:58'
      end
      i = Item.new(
        id: 1,
        name: 'Pencil',
        description: 'You can use it to write things',
        cent_price: 1099,
        created_at: Time.now.to_s,
        updated_at: '12:58',
        merchant_id: 2,
        repository: 'repository'
      )
      expect(i.updated_at).to eq('12:58')
    end
  end
  describe '#unit_price_to_dollars' do
    i = Item.new(
      id: 1,
      name: 'Pencil',
      description: 'You can use it to write things',
      cent_price: 1099,
      created_at: Time.now.to_s,
      updated_at: Time.now.to_s,
      merchant_id: 2,
      repository: 'repository'
    )
    it 'converts unit price to dollars' do
      expect(i.unit_price_to_dollars).to eq(10.99)
    end
  end

  describe '#update' do
    it 'updates' do

      i = Item.new(
        id: 1,
        name: 'Pencil',
        description: 'You can use it to write things',
        cent_price: 1099,
        created_at: Time.now.to_s,
        updated_at: Time.now.to_s,
        merchant_id: 2,
        repository: 'repository'
      )

      expect(i.name).to eq('Pencil')
      i.update(name: 'Lightsaber')
      expect(i.name).to eq('Lightsaber')

      expect(i.description).to eq('You can use it to write things')
      i.update(description: 'The key to the dark side')
      expect(i.description).to eq('The key to the dark side')

      expect(i.cent_price).to eq(1099)
      i.update(unit_price: 7000)
      expect(i.unit_price).to eq(7000)

      expect(i.updated_at).not_to eq(i.created_at)
    end
  end
end
