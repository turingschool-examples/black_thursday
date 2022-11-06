
require 'simplecov'
SimpleCov.start
require './lib/item_repository'
require 'pry'

RSpec.describe ItemRepository do
  let(:repo) { ItemRepository.new }
  it 'creates new instance with attributes' do
    i1 = repo.create({
                       id: 1,
                       name: 'Pencil',
                       description: 'You can use it to write things',
                       unit_price: BigDecimal(10.99, 4),
                       created_at: Time.now,
                       updated_at: Time.now,
                       merchant_id: 2
                     })
    expect(repo.all).to eq([i1])

    i2 = repo.create({

                       name: 'Pencil',
                       description: 'You can use it to write things',
                       unit_price: BigDecimal(10.99, 4),
                       created_at: Time.now,
                       updated_at: Time.now,
                       merchant_id: 2
                     })

    expect(i1.id).to eq(1)
    expect(repo.all).to eq([i1, i2])
    expect(i2.id).to eq(2)
  end

  context 'create item' do
    before(:each) do
      repo.create({
                    id: 1,
                    name: 'Pencil',
                    description: 'You can use it to write things',
                    unit_price: BigDecimal(10.99, 4),
                    created_at: Time.now,
                    updated_at: Time.now,
                    merchant_id: 2
                  })
    end

    it 'returns all known item instances' do
      expect(repo.all[0]).to be_instance_of(Item)
    end

    it 'finds by ID' do
      expect(repo.find_by_id(1)).to be_instance_of(Item)
      expect(repo.find_by_id(45)).to eq(nil)
    end

    it 'finds by name' do
      expect(repo.find_by_name('Pencil')).to be_instance_of(Item)
      expect(repo.find_by_name('pencil')).to be_instance_of(Item)
      expect(repo.find_by_name('Marker')).to eq(nil)
    end

    it 'finds all by description' do
      expect(repo.find_all_with_description('You can use it to write things')[0]).to be_instance_of(Item)
      expect(repo.find_all_with_description('you can use it to write things')[0]).to be_instance_of(Item)

      expect(repo.find_all_with_description('Marker')).to eq([])
      expect(repo.find_all_with_description('Pencil')).to eq([])
    end

    it 'finds all by price' do
      expect(repo.find_all_by_price(10.99)[0]).to be_instance_of(Item)
      expect(repo.find_all_by_price(20)).to eq([])
      expect(repo.find_all_by_price(0)).to eq([])
    end

    it 'finds all by price in range' do
      expect(repo.find_all_by_price_in_range((10..11))[0]).to be_instance_of(Item)
      expect(repo.find_all_by_price_in_range((0..3))).to eq([])
    end

    it 'finds all by price in range' do
      expect(repo.find_all_by_merchant_id(2)[0]).to be_instance_of(Item)
      expect(repo.find_all_by_merchant_id(87)).to eq([])
    end

    it 'updates Item instance' do
      repo.update(1, {
                    name: 'Paint Brush',
                    description: 'You can use it to paint things',
                    unit_price: BigDecimal(12.99, 4)
                  })
      expect(repo.find_by_id(1).name).to eq('Paint Brush')
    end

    it 'deletes item by id' do
      repo.delete(1)
      expect(repo.items).to eq([])
    end
  end
end
