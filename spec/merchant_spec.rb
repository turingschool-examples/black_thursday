require 'pry'
require_relative '../lib/merchant'


RSpec.describe do Merchant
  it 'exists and has attributes' do
    merchant = Merchant.new({:id => 5, :name => 'Turing School'})

    expect(merchant).to be_a Merchant
    expect(merchant.id).to eq 5
    expect(merchant.name).to eq('Turing School')
  end
end
