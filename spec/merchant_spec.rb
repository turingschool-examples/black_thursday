require 'SimpleCov'
SimpleCov.start

require_relative '../lib/salesengine'
require_relative '../lib/merchant'

RSpec.describe Merchant do
  it 'exists' do
    m = Merchant.new({:id => 5, :name => "Turing School"})

    expect(m).to be_an_instance_of(Merchant)
  end

  it 'initializes with attributes' do
    data = {:id => 5, :name => "Turing School"}
    m = Merchant.new(data)

    expect(m.id).to eq(data[:id])
    expect(m.name).to eq(data[:name])
  end
end
