require 'SimpleCov'
SimpleCov.start

require_relative '../lib/salesengine'
require_relative '../lib/merchant'
require_relative '../lib/item'
require 'bigdecimal'

RSpec.describe Item do
  it 'exists' do
    i = Item.new({
      :id          => 1,
      :name        => "Pencil",
      :description => "You can use it to write things",
      :unit_price  => BigDecimal::new(10.99,4),
      :created_at  => Time.now,
      :updated_at  => Time.now,
      :merchant_id => 2
    })

    expect(i).to be_an_instance_of(Item)
  end

  xit 'initializes with attributes' do
    data = {:id => 5, :name => "Turing School"}
    m = Merchant.new(data)

    expect(m.id).to eq(data[:id])
    expect(m.name).to eq(data[:name])
  end
end
