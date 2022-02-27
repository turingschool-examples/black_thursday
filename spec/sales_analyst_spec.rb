require './lib/sales_engine'
require 'pry'
require 'bigdecimal'

RSpec.describe ItemRepository do
  before(:each) do
    @se = SalesEngine.from_csv({
                                 items: './data/items.csv',
                                 merchants: './data/merchants.csv'
                               })
    @sales_analyst = @se.analyst
  end

<<<<<<< HEAD
  it '#average_items_per_merchant returns average items per merchant' do
    expected = @sales_analyst.average_items_per_merchant
=======
  it "#average_items_per_merchant returns average items per merchant" do
    expected = @sa.average_items_per_merchant
>>>>>>> origin

    expect(expected).to eq 2.88
    expect(expected.class).to eq Float
  end

<<<<<<< HEAD
  it ' ' do
    en
=======
  it "#average_items_per_merchant_standard_deviation returns the standard deviation" do
    expected = @sa.average_items_per_merchant_standard_deviation

    expect(expected).to eq 3.26
    expect(expected.class).to eq Float
>>>>>>> origin
  end
end
