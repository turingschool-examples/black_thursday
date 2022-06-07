require 'pry'
require_relative '../lib/item'
require 'BigDecimal'


RSpec.describe do Item
    before :each do
        @i = Item.new({
            :id          => 1,
            :name        => "Pencil",
            :description => "You can use it to write things",
            :unit_price  => BigDecimal(10.99,4),
            :created_at  => Time.now,
            :updated_at  => Time.now,
            :merchant_id => 2
            })
    end
    it 'exists and has attributes' do
        expect(@i).to be_a Item
        expect(@i.id).to eq 1
        expect(@i.name).to eq "Pencil"
        expect(@i.description).to eq "You can use it to write things"
        expect(@i.unit_price).to eq BigDecimal(10.99,4)
        expect(@i.created_at).to eq @i.created_at
        expect(@i.created_at).to be_a Time
        expect(@i.updated_at).to eq @i.updated_at
        expect(@i.updated_at).to be_a Time
        expect(@i.merchant_id).to eq 2
    end

    it 'returns the price of the item in dollars formatted as a Float' do
        expect(@i.unit_price_to_dollars).to eq 10.99
    end
end
