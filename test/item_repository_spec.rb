require './lib/item'
require './lib/item_repository'

RSpec.describe ItemRepository do
  let(:repo) { ItemRepository.new }
  it 'returns all known item instances' do
    expect(repo.all).to eq([])
    repo.create({
                   id: 1,
                   name: 'Pencil',
                   description: 'You can use it to write things',
                   unit_price: BigDecimal(10.99, 4),
                   created_at: Time.now,
                   updated_at: Time.now,
                   merchant_id: 2
                 })
                #  require 'pry'; binding.pry
    expect(repo.all[0]).to be_instance_of(Item)
  end

  it 'finds by ID' do
    repo.create({
                   id: 1,
                   name: 'Pencil',
                   description: 'You can use it to write things',
                   unit_price: BigDecimal(10.99, 4),
                   created_at: Time.now,
                   updated_at: Time.now,
                   merchant_id: 2
                 })
    expect(repo.find_by_id(1)).to be_instance_of(Item)
    expect(repo.find_by_id(45)).to eq(nil)
  end

  it 'finds by name' do
    repo.create({
                   id: 1,
                   name: 'Pencil',
                   description: 'You can use it to write things',
                   unit_price: BigDecimal(10.99, 4),
                   created_at: Time.now,
                   updated_at: Time.now,
                   merchant_id: 2
                 })
    expect(repo.find_by_name('Pencil')).to be_instance_of(Item)
    expect(repo.find_by_name('Marker')).to eq(nil)
  end

  it 'finds all by description' do
    repo.create({
                   id: 1,
                   name: 'Pencil',
                   description: 'You can use it to write things',
                   unit_price: BigDecimal(10.99, 4),
                   created_at: Time.now,
                   updated_at: Time.now,
                   merchant_id: 2
                 })
    expect(repo.find_all_with_description('You can use it to write things')[0]).to be_instance_of(Item)
    expect(repo.find_all_with_description('Marker')).to eq([])
    expect(repo.find_all_with_description('Pencil')).to eq([])
  end

  it 'finds all by price' do
    repo.create({
                   id: 1,
                   name: 'Pencil',
                   description: 'You can use it to write things',
                   unit_price: BigDecimal(10.99, 4),
                   created_at: Time.now,
                   updated_at: Time.now,
                   merchant_id: 2
                 })
    expect(repo.find_all_by_price(10.99)[0]).to be_instance_of(Item)
    expect(repo.find_all_by_price(20)).to eq([])
    expect(repo.find_all_by_price(0)).to eq([])
  end

  it 'finds all by price in range' do
    repo.create({
                   id: 1,
                   name: 'Pencil',
                   description: 'You can use it to write things',
                   unit_price: BigDecimal(10.99, 4),
                   created_at: Time.now,
                   updated_at: Time.now,
                   merchant_id: 2
                 })
    expect(repo.find_all_by_price_in_range((10..11))[0]).to be_instance_of(Item)
    expect(repo.find_all_by_price_in_range((0..3))).to eq([])
  end

  it 'finds all by price in range' do
    repo.create({
                   id: 1,
                   name: 'Pencil',
                   description: 'You can use it to write things',
                   unit_price: BigDecimal(10.99, 4),
                   created_at: Time.now,
                   updated_at: Time.now,
                   merchant_id: 2
                 })
    expect(repo.find_all_by_merchant_id(2)[0]).to be_instance_of(Item)
    expect(repo.find_all_by_merchant_id(87)).to eq([])
  end

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

  it 'updates Item instance' do
    # repo = repo.new
    repo.create({
                   id: 1,
                   name: 'Pencil',
                   description: 'You can use it to write things',
                   unit_price: BigDecimal(10.99, 4),
                   created_at: Time.now,
                   updated_at: Time.now,
                   merchant_id: 2
                 })
    repo.update(1, {
             name: 'Paint Brush',
             description: 'You can use it to paint things',
             unit_price: BigDecimal(12.99, 4)
           })
          #  require 'pry'; binding.pry
    expect(repo.find_by_id(1).name).to eq('paint brush')
    # expect(i.description).to eq('you can use it to paint things')
    # expect(i.unit_price_to_dollars).to eq(12.99)
    # test objspace in pry
    #  create instances of item without variables
    # run self.all in pry to see if instance obj is returned
    # instance variable for repo
  end
end
