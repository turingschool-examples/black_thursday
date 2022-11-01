require 'rspec'
require './lib/item'
require 'bigdecimal'

describe Item do
  describe '#initialize' do
   it 'exist' do
      i = Item.new({
        :id          => 1,
        :name        => "Pencil",
        :description => "You can use it to write things",
      })

      expect(i).to be_a(Item)
    end

    it 'has attributes' do
      i = Item.new({
        :id          => 1,
        :name        => "Pencil",
        :description => "You can use it to write things",
        :unit_price  => BigDecimal(10.99,4),
        :created_at  => created = Time.now,
        :updated_at  => updated = Time.now,
        :merchant_id => 2
      })

      expect(i.id).to eq(1)
      expect(i.name).to eq("Pencil")
      expect(i.description).to eq("You can use it to write things")
      expect(i.unit_price).to eq(BigDecimal(10.99,4))
      expect(i.created_at).to eq(created)
      expect(i.updated_at).to eq(updated)
      expect(i.merchant_id).to eq(2)
    end
  end
end


