require_relative 'spec_helper'

RSpec.describe Item do
  describe 'instantiation' do
    it 'exists' do
      item = Item.new({
        :id          => 1,
        :name        => "Pencil",
        :description => "You can use it to write things",
        :unit_price  => BigDecimal(10.99,4),
        :created_at  => Time.now,
        :updated_at  => Time.now,
        :merchant_id => 2
        })

      expect(item).to be_a(Item)
    end

    it 'has readable attributes' do
      item = Item.new({
        :id          => 1,
        :name        => "Pencil",
        :description => "You can use it to write things",
        :unit_price  => BigDecimal(10.99,4),
        :created_at  => Time.now,
        :updated_at  => Time.now,
        :merchant_id => 2
        })

      expect(item.id).to eq(1)
      expect(item.name).to eq("Pencil")
      expect(item.description).to eq("You can use it to write things")
      expect(item.unit_price).to eq(0.1099e2)
      expect(item.created_at).to be_an_instance_of(Time)
      expect(item.updated_at).to be_an_instance_of(Time)
      expect(item.merchant_id).to eq(2)
    end
  end
end
