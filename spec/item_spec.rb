require './lib/item'
require 'bigdecimal'

RSpec.describe Item do
  describe 'instantiation' do
    it '::new' do
      item1 = Item.new({:id          => 1,
                        :name        => "Pencil",
                        :description => "You can use it to write things",
                        :unit_price  => BigDecimal(10.99,4),
                        :created_at  => Time.now,
                        :updated_at  => Time.now,
                        :merchant_id => 2})

      expect(item1).to be_an_instance_of(Item)
    end

    it 'has attributes' do
      item1 = Item.new({:id          => 1,
                        :name        => "Pencil",
                        :description => "You can use it to write things",
                        :unit_price  => BigDecimal(10.99,4),
                        :created_at  => Time.now,
                        :updated_at  => Time.now,
                        :merchant_id => 2})
      
      expect(item1.id).to eq(1)
      expect(item1.name).to eq("Pencil")
      expect(item1.description).to eq("You can use it to write things")
      expect(item1.unit_price).to be_an_instance_of(BigDecimal)
      expect(item1.created_at).to be_an_instance_of(Time)
      expect(item1.updated_at).to be_an_instance_of(Time)
    end
  end

  describe '#methods' do
    it '#unit price to dollars' do
      item = Item.new({:id          => 1,
                        :name        => "Pencil",
                        :description => "You can use it to write things",
                        :unit_price  => 1099,
                        :created_at  => Time.now,
                        :updated_at  => Time.now,
                        :merchant_id => 2})
    
      expect(item.unit_price_to_dollars).to eq(10.99)
    end
  end
end

