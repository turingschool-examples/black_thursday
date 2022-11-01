require './test/spec_helper'
require 'bigdecimal/util'

RSpec.describe Item do 
  describe "#intialize" do
    it 'exists' do 
      item = Item.new({:id => 1,
                       :name => "item_name", 
                       :description => "item_description" ,
                       :unit_price => BigDecimal(10.99,4), 
                       :created_at => Time.now, 
                       :updated_at => Time.now,
                       :merchant_id => 1})

    expect(item).to be_a(Item)
    end 

    it 'has attributes' do 
      item = Item.new({:id => 1,
        :name => "item_name", 
        :description => "item_description" ,
        :unit_price => BigDecimal(10.99, 4), 
        :created_at => "2022-10-31 15:57:01.540729000 -0600", 
        :updated_at => "2022-10-31 15:57:01.540729000 -0600",
        :merchant_id => 1})

      expect(item.id).to eq(1)
      expect(item.name).to eq("item_name")
      expect(item.description).to eq("item_description")
      expect(item.unit_price).to eq(0.1099e2)
      expect(item.created_at).to eq("2022-10-31 15:57:01.540729000 -0600")
      expect(item.updated_at).to eq("2022-10-31 15:57:01.540729000 -0600")
      expect(item.merchant_id).to eq(1)
    end
  end

  describe '#unit_price_to_dollars' do 
    it 'returns a formatted float' do
      item = Item.new({:id => 1,
        :name => "item_name", 
        :description => "item_description" ,
        :unit_price => BigDecimal(10.99, 4), 
        :created_at => "2022-10-31 15:57:01.540729000 -0600", 
        :updated_at => "2022-10-31 15:57:01.540729000 -0600",
        :merchant_id => 1})

        expect(item.unit_price_to_dollars).to eq(10.99)
      end 
    end
    
  describe '#update()' do
    let (:item) {Item.new({:id => 1,
      :name => "item_name", 
      :description => "item_description" ,
      :unit_price => BigDecimal(10.99, 4), 
      :created_at => "2022-10-31 15:57:01.540729000 -0600", 
      :updated_at => "2022-10-31 15:57:01.540729000 -0600",
      :merchant_id => 1})}
      
    it 'can update the item name' do
      item.update_name("candle")
      expect(item.name).to eq("candle")
    end
    
    it 'can update the item description' do
      item.update_description("taper candle")
      expect(item.description).to eq("taper candle")
    end
    
    # it 'can update the item unit price' do
    #   item.update_unit_price(11.99, 4)
    #   expect(item.unit_price).to eq(11.99, 4)
    # end
  end
end 