require_relative '../lib/sales_engine'
require_relative '../lib/item_repository'
require_relative '../lib/item'
require 'BigDecimal'

RSpec.describe Item do

  describe '#initialize' do
    item = Item.new({
                      :id          => 1,
                      :name        => "Pencil",
                      :description => "You can use it to write things",
                      :unit_price  => 10.88, # BigDecimal.new(10.99,4),
                      :created_at  => Time.now,
                      :updated_at  => Time.now,
                      :merchant_id => 2
                    })

    it 'exists' do
      expect(item).to be_instance_of(Item)
    end

    it 'has attributes available' do
      expect(item.id).to eq(1)
      expect(item.name).to eq("Pencil")
      expect(item.description).to eq("You can use it to write things")
      expect(item.unit_price).to eq(10.88) #When we use BigDecimal, test bu checking object class 
      expect(item.created_at.class).to eq(Time)
      expect(item.updated_at.class).to eq(Time)
      expect(item.merchant_id).to eq(2)
    end
  end
end
