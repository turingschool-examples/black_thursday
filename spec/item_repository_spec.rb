require './lib/item_repository'
require './lib/item'
require 'rspec'
require 'simplecov'
require 'bigdecimal'

SimpleCov.start

RSpec.describe ItemRepository do
  it 'exists' do
    ir = ItemRepository.new

    expect(ir).to be_a(ItemRepository)
  end

  it 'has readable attributes' do
    ir = ItemRepository.new
    i = Item.new({
      :id          => 1,
      :name        => "Pencil",
      :description => "You can use it to write things",
      :unit_price  => BigDecimal(10.99,4),
      :created_at  => Time.now,
      :updated_at  => Time.now,
      :merchant_id => 2
    })

    expect(ir.all).to be_a(Array)
    expect(ir.all).to eq([])

    ir.all << i
    
    expect(ir.all).to be_a(Array)
    expect(ir.all).to eq([i])
  end

end
