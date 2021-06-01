require 'SimpleCov'
SimpleCov.start

require_relative '../lib/salesengine'
require_relative '../lib/merchant'
require_relative '../lib/merchantrepository'
require_relative '../lib/itemrepository'
require_relative '../lib/item'

RSpec.describe ItemRepository do
  it 'exists' do
    data = {
      :id          => 1,
      :name        => "Pencil",
      :description => "You can use it to write things",
      :unit_price  => BigDecimal(10.99,4),
      :created_at  => Time.now,
      :updated_at  => Time.now,
      :merchant_id => 2
    }
    i = Item.new(data)
    i2 = Item.new(data)
    ir = ItemRepository.new([i, i2])

    expect(ir).to be_an_instance_of(ItemRepository)
  end

end
