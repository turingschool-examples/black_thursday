require './lib/sales_engine'
require './lib/item'
require 'bigdecimal'
require 'bigdecimal/util'
require 'rspec'
require 'csv'
require './lib/merchantrepository'
require './lib/merchant'

describe SalesEngine do

  it 'exists' do
    se = SalesEngine.from_csv({
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv",
    })

    expect(se).to be_a(SalesEngine)
  end


  it "adds new instances of merchant repository" do
    se = SalesEngine.from_csv({
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv",
    })

    mr = se.merchants

    expect(mr).to be_a(MerchantRepository)
    expect(se.merchants).to be_an_instance_of(MerchantRepository)
    expect(se.merchants.all[0]).to be_a(Merchant)
    expect(mr.find_by_id(12334135).name).to eq("GoldenRayPress")
  end

  it "can create an array of items from csv input" do
    se = SalesEngine.from_csv({
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv",
    })

    ir = se.items

    expect(ir.find_by_id(263395721)).to be_an_instance_of(Item)
    expect(ir.all.length).to eq(1367)
   end
end
