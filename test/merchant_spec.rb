require './lib/merchant.rb'

RSpec. describe Merchant do
    it 'exists' do
        merchant = Merchant.new({:id => 5, :name => "Turing School"})

        expect(merchant).to eq(merchant)
    end
end