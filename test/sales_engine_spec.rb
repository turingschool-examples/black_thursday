require './lib/sales_engine'
require 'rspec'
require 'csv'
require './lib/merchantrepository'
#
describe SalesEngine do

  it 'exists' do
    se = SalesEngine.from_csv({
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv",
    })

    expect(se).to be_a(SalesEngine)
  end

  it "adds new instances of merchant" do
    se = SalesEngine.from_csv({
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv",
    })
    mr = se.merchants
    expect(mr).to be_a(MerchantRepository)
    expect(mr.find_by_id(12334160)).to eq({:created_at=>"2009-01-18", :id=>12334160, :name=>"byMarieinLondon", :updated_at=>"2011-05-04"})


  end
end
