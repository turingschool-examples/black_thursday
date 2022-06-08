require './lib/helper'
SimpleCov.start

RSpec.describe Item do
  let!(:item) {Item.new({
    :id => 1,
    :name => "Pencil",
    :description => "You can use it to write things",
    :unit_price => BigDecimal(10.99,4),
    :created_at => Time.now.strftime("%Y-%m-%d %H:%M"),
    :updated_at => Time.now,
    :merchant_id => 2
  })}

  it 'exists' do
    expect(item).to be_instance_of(Item)
  end

  it 'returns id' do
    expect(item.id).to eq(1)
  end

  it 'returns name' do
    expect(item.name).to eq("Pencil")
  end

  it 'returns description' do
    expect(item.description).to eq("You can use it to write things")
  end

  it 'returns unit price' do
    expect(item.unit_price).to eq(BigDecimal(10.99,4))
  end

  it 'returns time created' do
    expect(item.created_at).to eq(Time.now.strftime("%Y-%m-%d %H:%M"))
    #this doesn't pass because the expect is called slightlllllly after the object is inialized
  end

  it 'returns time updated' do
    expect(item.unit_price_to_dollars).to eq(10.99)
    item.update(1, {description: 'Ink pen', unit_price: BigDecimal(17.99,4)})
    expect(item.updated_at).to eq(Time.now.strftime("%Y-%m-%d %H:%M"))
    expect(item.unit_price_to_dollars).to eq(17.99)
    #this doesn't pass because the expect is called slightlllllly after the object is inialized
  end

  it 'returns merchant id' do
    expect(item.merchant_id).to eq(2)
  end

  it 'returns unit price in dollars' do
    expect(item.unit_price_to_dollars).to eq(10.99)
  end

end
