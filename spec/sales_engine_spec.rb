require './lib/sales_engine'

RSpec.describe SalesEngine do
  it 'exists' do

  se = SalesEngine.new()
    expect(se).to be_an_instance_of(SalesEngine)
  end

  xit 'has attributes' do
    se = SalesEngine.new()
    expect(x).to eq("...")
  end
end

