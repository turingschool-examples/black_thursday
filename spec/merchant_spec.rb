require_relative '../lib/merchant'

RSpec.describe Merchant do
  it 'exists' do
    m = Merchant.new({id: 5, name: "Turing School", created_at: Time.now.to_s, updated_at: Time.now.to_s})

    expect(m).to be_a (Merchant)
  end

  it 'has attributes' do
    m = Merchant.new({id: 5, name: "Turing School", created_at: Time.now.to_s, updated_at: Time.now.to_s})

    expect(m.id).to eq (5)
    expect(m.name).to eq ("Turing School")
  end
end