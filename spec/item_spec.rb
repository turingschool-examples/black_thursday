require_relative '../lib/item'
require 'bigdecimal'
require 'simplecov'
SimpleCov.start

RSpec.describe Item do

  context 'create Item class' do
    time = Time.new
    i = Item.new({
      :id          => 1,
      :name        => "Pencil",
      :description => "You can use it to write things",
      :unit_price  => BigDecimal(10.99,4),
      :created_at  => time,
      :updated_at  => time,
      :merchant_id => 2
    })

    it 'exists' do
      expect(i).to be_an_instance_of(Item)
    end

    it 'has attributes' do
      expect(i.id).to eq(1)
      expect(i.name).to eq("Pencil")
      expect(i.description).to eq("You can use it to write things")
      expect(i.unit_price).to eq(BigDecimal(10.99,4))
      expect(i.created_at).to eq(time)
      expect(i.updated_at).to eq(time)
      expect(i.merchant_id).to eq(2)
    end

  end

end
