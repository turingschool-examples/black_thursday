require './lib/requirements'

RSpec.describe Merchant do
  let!(:m) {Merchant.new({:id =>5, :name => "Turing School"}, nil)}
  it 'is a merchant class' do
    expect(m).to be_a Merchant    
  end

  it 'accepts the integer id of merchant' do
    expect(m.id).to eq 5
  end
  
  it 'accepts the name of merchant' do
    expect(m.name).to eq "Turing School"
  end
end