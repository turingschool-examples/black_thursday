require 'rspec'
require './lib/merchant'

describe Merchant do
  it 'exists' do
    merchant = Merchant.new({id: "5",name: "Brian",created_at: "10-05-1988",updated_at: "06-03-2021"}, self)

    expect(merchant).to be_a(Merchant)
  end

  it 'has attributes' do
    merchant = Merchant.new({id: "5",name: "Brian",created_at: "10-05-1988",updated_at: "06-03-2021"}, self)

    expect(merchant.id).to eq(5)
    expect(merchant.name).to eq("Brian")
    expect(merchant.created_at).to eq("10-05-1988")
    expect(merchant.updated_at).to eq("06-03-2021")
    expect(merchant.repo).to eq(self)
  end

  it 'can change name' do
    merchant = Merchant.new({id: "5",name: "Brian",created_at: "10-05-1988",updated_at: "06-03-2021"}, self)

    expect(merchant.name).to eq("Brian")

    merchant.change_name("Ezze")

    expect(merchant.name).to eq("Ezze")
  end

end
