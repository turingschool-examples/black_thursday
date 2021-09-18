require './lib/sales_analyst'
require './lib/sales_engine'
require './lib/items'
require './lib/merchants'

RSpec.describe SalesAnalyst do
  before(:each) do
    @engine = SalesEngine.from_csv({
                                items: './data/items.csv',
                                merchants: './data/merchants.csv'
                                  })
    @sales_analyst = @engine.analyst
  end

  it 'exists' do
    expect(@sales_analyst).to be_an_instance_of(SalesAnalyst)
  end

  it "#average_items_per_merchant returns average items per merchant" do
    expected = @sales_analyst.average_items_per_merchant

    expect(expected).to eq 2.88
    expect(expected.class).to eq Float
  end

  it "#average_items_per_merchant_standard_deviation returns the standard deviation" do
    expected = @sales_analyst.average_items_per_merchant_standard_deviation

    expect(expected).to eq 3.26
    expect(expected.class).to eq Float
  end


end
