require "./lib/sales_analyst"

RSpec.describe SalesAnalyst do
  before :each do
    @sales_engine = SalesEngine.from_csv({
    :items     => "./data/items.csv",
    :merchants => "./data/merchants.csv",
    })
    @sales_analyst = @sales_engine.analyst
  end

  it "exists" do
    expect(@sales_engine).to be_a(SalesEngine)
    expect(@sales_analyst).to be_a(SalesAnalyst)
  end

  it 'gives average items per merchant' do
    # require "pry"; binding.pry
    expect(@sales_analyst.average_items_per_merchant).to eq(2.88)
  end

end
