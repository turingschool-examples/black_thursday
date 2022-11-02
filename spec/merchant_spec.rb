require 'rspec'
require './lib/merchant'

RSpec.describe do
  it 'exists' do
    m = Merchant.new({:id => 5, :name => "Turing School"})

    expect(m).to be_a(Merchant)
  end

  it 'has a name and id' do
      m = Merchant.new({:id => 5, :name => "Turing School"})

      expect(m.id).to eq(5)
      expect(m.name).to eq("Turing School")
  end
end
