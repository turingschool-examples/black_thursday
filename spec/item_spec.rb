# frozen_string_literal: true

require 'rspec'
require './lib/item'

describe Item do
  describe '#initialize' do
    it 'exists' do
      details = {
        id: 1,
        name: 'Pencil',
        description: 'You can use it to write things',
        unit_price: '1099',
        created_at: Time.now,
        updated_at: Time.now,
        merchant_id: 2
      }
      item = Item.new(details)

      expect(item).is_a? Item
    end

    it 'has an id' do
      details = {
        id: 1,
        name: 'Pencil',
        description: 'You can use it to write things',
        unit_price: '1099',
        created_at: Time.now,
        updated_at: Time.now,
        merchant_id: 2
      }
      item = Item.new(details)

      expect(item.id).to eq 1
      expect(item.id).is_a? Integer
    end

    it 'has a name' do
      details = {
        id: 1,
        name: 'Pencil',
        description: 'You can use it to write things',
        unit_price: '1099',
        created_at: Time.now,
        updated_at: Time.now,
        merchant_id: 2
      }
      item = Item.new(details)

      expect(item.name).to eq 'Pencil'
      expect(item.name).is_a? String
    end

    it 'has a description' do
      details = {
        id: 1,
        name: 'Pencil',
        description: 'You can use it to write things',
        unit_price: '1099',
        created_at: Time.now,
        updated_at: Time.now,
        merchant_id: 2
      }
      item = Item.new(details)

      expect(item.description).to eq 'You can use it to write things'
      expect(item.description).is_a? String
    end

    it 'has a unit price' do
      details = {
        id: 1,
        name: 'Pencil',
        description: 'You can use it to write things',
        unit_price: '1099',
        created_at: Time.now,
        updated_at: Time.now,
        merchant_id: 2
      }
      item = Item.new(details)

      expect(item.unit_price).to eq BigDecimal(10.99, 4)
      expect(item.unit_price).is_a? BigDecimal
    end

    it 'has a created_at Time' do
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

      expect(item.created_at).to eq(Time.parse('2007-06-04 21:35:10 UTC'))
      expect(item.created_at).is_a? Time
    end

    it 'has a updated_at Time' do
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

      expect(item.updated_at).to eq(Time.parse('2007-06-04 21:35:10 UTC'))
      expect(item.updated_at).is_a? Time
    end

    it 'has a merchant_id' do
      details = {
        id: 1,
        name: 'Pencil',
        description: 'You can use it to write things',
        unit_price: '1099',
        created_at: Time.now,
        updated_at: Time.now,
        merchant_id: 2
      }
      item = Item.new(details)

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
        created_at: Time.now,
        updated_at: Time.now,
        merchant_id: 2
      }
      item = Item.new(details)

      expect(item.unit_price_to_dollars).to eq(25.00)
    end
  end
end
