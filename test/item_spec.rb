require './lib/item'
require 'bigdecimal/util'

RSpec.describe Item do 
  describe "#intialize" do
    it 'exists' do 
      item = Item.new({"id" => 1,
                       "name" => "item_name", 
                       "description" => "item_description" ,
                       "unit_price" => BigDecimal("5.99"), 
                       "created_at" => Time.now, 
                       "updated_at" => Time.now,
                       "merchant_id" => 1})

    expect(item).to be_a(Item)

    end 
  end
end 