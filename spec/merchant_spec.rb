require 'rspec'
require './lib/merchant'

RSpec.describe do
  it 'exists' do
    m = Merchant.new({:id => 5, :name => "Turing School"})

    expect(m).to be_a(Merchant)
  end
end
