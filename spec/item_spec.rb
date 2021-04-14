require './lib/item'
require 'bigdecimal'
require 'RSpec'

RSpec.describe Item do
  describe '#initialize' do
    i = Item.new(
      id: 1,
      name: 'Pencil',
      description: 'You can use it to write things',
      unit_price: BigDecimal(10.99, 4),
      created_at: Time.now,
      updated_at: Time.now,
      merchant_id: 2
    )
    it 'exists' do
      expect(i).to be_an_instance_of(Item)
    end
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
      expect(i.unit_price).to eq(BigDecimal(10.99, 4))
    end
    it 'has a merchant id' do
      expect(i.merchant_id).to eq(2)
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
        unit_price: BigDecimal(10.99, 4),
        created_at: Time.now,
        updated_at: Time.now,
        merchant_id: 2
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
        unit_price: BigDecimal(10.99, 4),
        created_at: Time.now,
        updated_at: Time.now,
        merchant_id: 2
      )
      expect(i.updated_at).to eq('12:58')
    end
  end
  describe '#unit_price_to_dollars' do
    i = Item.new(
      id: 1,
      name: 'Pencil',
      description: 'You can use it to write things',
      unit_price: BigDecimal(10.99, 4),
      created_at: Time.now,
      updated_at: Time.now,
      merchant_id: 2
    )
    it 'converts unit price to dollars' do
      expect(i.unit_price_to_dollars).to eq(10.99)
    end
  end
end
