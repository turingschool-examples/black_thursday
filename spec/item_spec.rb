require 'bigdecimal'
require 'rspec'

require './lib/item'

describe Item do
  describe '#initialize' do
    details = {
      id: 1,
      name: 'Pencil',
      description: 'You can use it to write things',
      unit_price: '1099',
      created_at: '2007-06-04 21:35:10 UTC',
      updated_at: '2007-06-04 21:35:10 UTC',
      merchant_id: 2
    }
    item = Item.new(details)

    it 'exists' do
      expect(item).is_a? Item
    end

    it 'has an id' do
      expect(item.id).to eq 1
      expect(item.id).is_a? Integer
    end

    it 'has a name' do
      expect(item.name).to eq 'Pencil'
      expect(item.name).is_a? String
    end

    it 'has a description' do
      expect(item.description).to eq 'You can use it to write things'
      expect(item.description).is_a? String
    end

    it 'has a unit price' do
      expect(item.unit_price).to eq BigDecimal(10.99, 4)
      expect(item.unit_price).is_a? BigDecimal
    end

    it 'has a created_at Time' do
      expect(item.created_at).to eq(Time.parse('2007-06-04 21:35:10 UTC'))
      expect(item.created_at).is_a? Time
    end

    it 'has a updated_at Time' do
      expect(item.updated_at).to eq(Time.parse('2007-06-04 21:35:10 UTC'))
      expect(item.updated_at).is_a? Time
    end

    it 'has a merchant_id' do
      expect(item.merchant_id).to eq 2
      expect(item.merchant_id).is_a? Integer
    end
  end

  describe '#unit_price_to_dollars' do
    it 'returns the price in dollars' do
      details = {
        id: 1,
        name: 'Pencil',
        description: 'You can use it to write things',
        unit_price: '2500',
        created_at: '2007-06-04 21:35:10 UTC',
        updated_at: '2007-06-04 21:35:10 UTC',
        merchant_id: 2
      }
      item = Item.new(details)

      expect(item.unit_price_to_dollars).to eq(25.00)
    end
  end

  describe '#update methods' do
    details = {
      id: 1,
      name: 'Pencil',
      description: 'You can use it to write things',
      unit_price: '2500',
      created_at: '2007-06-04 21:35:10 UTC',
      updated_at: '2007-06-04 21:35:10 UTC',
      merchant_id: 2
    }
    item = Item.new(details)

    it 'updates the id for the Item to specified id' do
      item.update_id(2)

      expect(item.id).to eq 2
    end

    it 'updates the name for the Item to specified name' do
      item.update_name('George')

      expect(item.name).to eq 'George'
    end

    it 'updates the description for the Item to specified description' do
      item.update_description('New words')

      expect(item.description).to eq 'New words'
    end

    it 'updates the unit_price for the Item to specified unit_price' do
      item.update_unit_price(10.99)

      expect(item.unit_price).to eq 10.99
    end

    it 'it updates nothing if input is nil' do
      item.update_name(nil)
      item.update_description(nil)
      item.update_unit_price(nil)

      expect(item.id).not_to be_nil
      expect(item.name).not_to be_nil
      expect(item.description).not_to be_nil
      expect(item.id).not_to be_nil
    end
  end

  describe '#updated_at' do
    it 'returns updated_at time with String input' do
      details = {
        id: 1,
        name: 'Pencil',
        description: 'You can use it to write things',
        unit_price: '2500',
        created_at: '2007-06-04 21:35:10 UTC',
        updated_at: '2007-06-04 21:35:10 UTC',
        merchant_id: 2
      }
      item = Item.new(details)

      expect(item.updated_at).to eq Time.parse('2007-06-04 21:35:10 UTC')
    end

    it 'returns updated_at time with Time input' do
      details = {
        id: 1,
        name: 'Pencil',
        description: 'You can use it to write things',
        unit_price: '2500',
        created_at: '2007-06-04 21:35:10 UTC',
        updated_at: Time.parse('2007-06-04 21:35:10 UTC'),
        merchant_id: 2
      }
      item = Item.new(details)

      expect(item.updated_at).to eq Time.parse('2007-06-04 21:35:10 UTC')
    end
  end

  describe '#created_at' do
    it 'returns created_at time with String input' do
      details = {
        id: 1,
        name: 'Pencil',
        description: 'You can use it to write things',
        unit_price: '2500',
        created_at: '2007-06-04 21:35:10 UTC',
        updated_at: '2007-06-04 21:35:10 UTC',
        merchant_id: 2
      }
      item = Item.new(details)

      expect(item.created_at).to eq Time.parse('2007-06-04 21:35:10 UTC')
    end

    it 'returns created_at time with Time input' do
      details = {
        id: 1,
        name: 'Pencil',
        description: 'You can use it to write things',
        unit_price: '2500',
        created_at: Time.parse('2007-06-04 21:35:10 UTC'),
        updated_at: '2007-06-04 21:35:10 UTC',
        merchant_id: 2
      }
      item = Item.new(details)

      expect(item.created_at).to eq Time.parse('2007-06-04 21:35:10 UTC')
    end
  end
end
