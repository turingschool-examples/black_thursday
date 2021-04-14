require 'RSpec'
require './lib/item'
require 'bigdecimal'

RSpec.describe Item do
  describe 'instantiation' do
    it '::new' do
      i = Item.new({:id          => 1,
                    :name        => "Pencil",
                    :description => "You can use it to write things",
                    :unit_price  => BigDecimal.new(10.99,4),
                    :created_at  => Time.now,
                    :updated_at  => Time.now,
                    :merchant_id => 2
                  })
      expect(i).to be_an_instance_of(Item)
    end

    it 'has attributes' do
      i = Item.new({:id          => 1,
      :name        => "Pencil",
      :description => "You can use it to write things",
      :unit_price  => BigDecimal(10.99,4),
      :created_at  => Time.now,
      :updated_at  => Time.now,
      :merchant_id => 2})
      
      expect(i.id).to eq(1)
      expect(i.name).to eq("Pencil")
      expect(i.description).to eq("You can use it to write things")
      expect(i.unit_price).to be_an_instance_of(BigDecimal)
      expect(i.created_at).to be_an_instance_of(Time)
      expect(i.updated_at).to be_an_instance_of(Time)
    end
  end
end

