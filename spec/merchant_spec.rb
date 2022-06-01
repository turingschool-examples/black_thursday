require './lib/merchant'
require './lib/sales_engine'

RSpec.describe Merchant do
  before :each do
    @m = Merchant.new({id: 5, :name => "Turing School"})
  end

  it 'exists' do
    expect(@m).to be_a(Merchant)
  end

  it 'has attributes' do
    expect(@m.id).to eq(5)
    expect(@m.name).to eq("Turing School")
  end

  it 'can update info' do
    attributes = { name: "New Name School Who Dis" }
    expect(@m.id).to eq(5)
    @m.update_info(attributes)
    expect(@m.name).to eq("New Name School Who Dis")
  end
end
