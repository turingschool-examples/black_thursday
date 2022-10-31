require './lib/item'

RSpec.describe Item do
  before(:each) do
    i = Item.new({
      :id          => 1,
      :name        => "Pencil",
      :description => "You can use it to write things",
      :unit_price  => BigDecimal(10.99,4),
      :created_at  => Time.now,
      :updated_at  => Time.now,
      :merchant_id => 2
    })
  end

  it '#initialize' do
    expect(i).to be_an_instance_of(Item)
  end

  it 'has id' do
    expect(i.id).to eq(1)
  end

  it 'has a name' do
    expect(i.name).to eq("Pencil")
  end

  it 'has a description' do
    expect(i.description).to eq("You can use it to write things")
  end

  it 'has a unit price' do

  end

  it 'has a date of creation' do

  end

  it 'has a date of update' do

  end

  it 'has a merchant id' do

  end
end


i.unit_price_to_dollars
# => 23.48
