require './lib/merchant'


RSpec.describe Merchant do
  it 'exists' do
    merchant = Merchant.new({:id => 5, :name => "Turing School"})

    expect(merchant).to be_a(Merchant)
  end

  it 'contains information' do
    merchant = Merchant.new({:id => 5, :name => "Turing School"})

    expect(merchant.id).to be(5)
    expect(merchant.name).to eq("Turing School")
  end

end

#line 15 gives me an error saying that the expected and the got are different but theyre exactly alike
