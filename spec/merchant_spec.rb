require './lib/merchant'

RSpec.describe Merchant do
  it 'exists' do
    m = Merchant.new({:id => 5, :name => "Turing School"})

    expect(m).to be_instance_of(Merchant)
  end
end
