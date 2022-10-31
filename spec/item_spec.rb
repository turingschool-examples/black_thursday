require './lib/item'

RSpec.describe Item do
  time_now = Time.now
  let!(:i) {Item.new(
    {
  :id          => 1,
  :name        => "Pencil",
  :description => "You can use it to write things",
  :unit_price  => BigDecimal(10.99,4),
  :created_at  => time_now,
  :updated_at  => time_now,
  :merchant_id => 2
  }
  )}

  it 'is an item class' do
    expect(i).to be_a(Item)
  end

  it 'is created with a hash storing the id, name, description, unit_price, created at, updated_at, merchant_id symbols' do
    expect(i.id).to eq(1)
    expect(i.name).to eq("Pencil")
    expect(i.description).to eq("You can use it to write things")
    expect(i.unit_price).to eq(BigDecimal(10.99,4))
    expect(i.created_at).to eq(time_now)
    expect(i.updated_at).to eq(time_now)
    expect(i.merchant_id).to eq(2)
  end

  it 'can convert unit price to a dollar formatted float' do
    expect(i.unit_price_to_dollars).to eq(10.99)
  end
end