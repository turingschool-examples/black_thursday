require './spec_helper'
require './lib/sales_engine'

RSpec.describe SalesEngine do
  it 'exists' do
    se = se = SalesEngine.new({
      :items     => './data/items.csv',
      :merchants => './data/merchants.csv',
    })

    expect(se).to be_a(SalesEngine)
  end
end
