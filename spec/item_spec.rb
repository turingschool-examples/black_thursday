require_relative './spec_helper'

RSpec.describe Item do
  context 'instantiation' do  
    before :each do
      @item = Item.new({
        :id          => 1,
        :name        => "Pencil",
        :description => "You can use it to write things",
        :unit_price  => BigDecimal(10.99,4),
        :created_at  => '1993-09-29 11:56:40 UTC',
        :updated_at  => '2016-01-11 11:51:37 UTC',
        :merchant_id => 2
      })
    end  
    
    it 'exists' do
      expect(@item).to be_a(Item)
    end

    it 'has attributes' do
      expect(@item.id).to eq(1)
      expect(@item.name).to eq('Pencil')
      expect(@item.description).to eq("You can use it to write things")
      expect(@item.unit_price).to eq(BigDecimal(10.99,4))
      expect(@item.created_at).to eq('1993-09-29 11:56:40 UTC')
      expect(@item.updated_at).to eq('2016-01-11 11:51:37 UTC')
      expect(@item.merchant_id).to eq(2)
    end
  end

  context 'methods' do
    it 'returns the price of the item in dollars formatted as a Float' do
      item = Item.new({
        :id          => 1,
        :name        => "Pencil",
        :description => "You can use it to write things",
        :unit_price  => BigDecimal(10.99,4),
        :created_at  => '1993-09-29 11:56:40 UTC',
        :updated_at  => '2016-01-11 11:51:37 UTC',
        :merchant_id => 2
      })

      expect(item.unit_price_to_dollars).to eq("$10.99")
    end
  end
end