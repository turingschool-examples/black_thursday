require './lib/item'
require 'bigdecimal/util'

RSpec.describe Item do 
  describe "#intialize" do
    it 'exists' do 
      item = Item.new({:id => 1,
                       :name => "item_name", 
                       :description => "item_description" ,
                       :unit_price => BigDecimal("5.99"), 
                       :created_at => Time.now, 
                       :updated_at => Time.now,
                       :merchant_id => 1})

    expect(item).to be_a(Item)

    end 

    it 'has attributes' do 
      item = Item.new({:id => 1,
        :name => "item_name", 
        :description => "item_description" ,
        :unit_price => BigDecimal("5.99"), 
        :created_at => "2022-10-31 15:57:01.540729000 -0600", 
        :updated_at => "2022-10-31 15:57:01.540729000 -0600",
        :merchant_id => 1})

      expect(item.id).to eq(1)
      expect(item.name).to eq("item_name")
      expect(item.description).to eq("item_description")
      expect(item.unit_price).to eq(BigDecimal("5.99"))
      expect(item.created_at).to eq("2022-10-31 15:57:01.540729000 -0600")
      expect(item.updated_at).to eq("2022-10-31 15:57:01.540729000 -0600")
      expect(item.merchant_id).to eq(1)
    end
  end
end 