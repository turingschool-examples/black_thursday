require './lib/merchant.rb'

RSpec. describe Merchant do
  it 'exists' do
    merchant = Merchant.new({:id => 5, :name => "Turing School"})

    expect(merchant).to eq(merchant)
  end

  it 'has an id' do
    merchant = Merchant.new({:id => 5, :name => "Turing School"})

    expect(merchant.id).to eq(5)
  end

  it 'has a name' do
    merchant = Merchant.new({:id => 5, :name => "Turing School"})

    expect(merchant.name).to eq("Turing School")
  end
end