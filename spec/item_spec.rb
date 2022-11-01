require './lib/item'

RSpec.describe Item do
  let!(:time_now) {Time.now}
  let!(:item) {Item.new(
    {
  :id          => 1,
  :name        => "Pencil",
  :description => "You can use it to write things",
  :unit_price  => BigDecimal(10.99,4),
  :created_at => time_now,
  :updated_at => time_now,
  :merchant_id => 2
  }
  )}

  it 'is an item class' do
    expect(item).to be_a(Item)
  end

  it 'is created with a hash storing the id, name, description, unit_price, created at, updated_at, merchant_id symbols' do
    expect(item.id).to eq(1)
    expect(item.name).to eq("Pencil")
    expect(item.description).to eq("You can use it to write things")
    expect(item.unit_price).to eq(BigDecimal(10.99,4))
    expect(item.created_at).to eq(time_now)
    expect(item.updated_at).to eq(time_now)
    expect(item.merchant_id).to eq(2)
  end

  it 'can convert unit price to a dollar formatted float' do
    expect(item.unit_price_to_dollars).to eq(10.99)
  end
end