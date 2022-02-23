require 'simplecov'
SimpleCov.start
require './lib/merchant'

RSpec.describe Merchant do
  before :each do
    info = {
      id: 5,
      name: 'Turing School'
    }
    @m = Merchant.new(info)
  end
  it 'exists' do
    expect(@m).to be_a(Merchant)
  end

  it 'has attributes' do
    expect(@m.id).to eq(5)
    expect(@m.name).to eq('Turing School')
  end
end
