require 'pry'
require './lib/item'


RSpec.describe do Item
    it 'exists and has attributes' do
        i = Item.new({
            :id          => 1,
            :name        => "Pencil",
            :description => "You can use it to write things",
            :unit_price  => BigDecimal(10.99,4),
            :created_at  => Time.now,
            :updated_at  => Time.now,
            :merchant_id => 2
            })
        expect(i).to be_a Item
        expect(i.id).to eq 1
        expect(i.name).to eq "Pencil"
        expect(i.description).to eq "You can use it to write things"
        expect(i.unit_price).to eq BigDecimal(10.99,4)
        expect(i.created_at).to eq Time.now
        expect(i.updated_at).to eq Time.now
        expect(i.merchant_id).to eq 2
    end
end