require './lib/item'

RSpec.describe Item do

  let!(i) {Item.new({
  :id          => 1,
  :name        => "Pencil",
  :description => "You can use it to write things",
  :unit_price  => BigDecimal(10.99,4),
  :created_at  => Time.now,
  :updated_at  => Time.now,
  :merchant_id => 2
  })}

  it 'is an item class' do
    
  end
  
  it 'is created with a hash storing the id, name, description, unit_price, created at, updated_at, merchant_id symbols' do

  end

  it 'can convert unit price to a dollar formatted float' do
    # expect(i.unit_price_to_dollars).to eq 23.48
  end
  
end