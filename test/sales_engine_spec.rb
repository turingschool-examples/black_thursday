require './lib/sales_engine'
require 'rspec'
require 'csv'
require './lib/merchantrepository'
# require '/lib/merchant'
#
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
    # merchant_repository_1 = MerchantRepository.new
                                                  # ({
                                                  #   id: 12334135,
                                                  #   name: "GoldenRayPress",
                                                  #   created_at: "2011-12-13",
                                                  #   updated_at: "2012-04-16"
                                                  # })
    mr = se.merchants
    # require "pry"; binding.pry
    expect(mr).to be_a(MerchantRepository)
    require "pry"; binding.pry
    expect(mr.find_by_id(12334135)).to eq({:created_at=>"2011-12-13", :id=>12334135, :name=>"GoldenRayPress", :updated_at=>"2012-04-16"})


  end
end
