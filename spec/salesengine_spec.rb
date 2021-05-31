require 'SimpleCov'
SimpleCov.start

require_relative '../lib/salesengine'

RSpec.describe SalesEngine do
  it 'exists' do
    se = SalesEngine.from_csv({
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv"
    })

    # ir   = se.items
    # item = ir.find_by_name("Item Repellat Dolorum")
    expect(se).to be_an_instance_of(SalesEngine)
  end

  it 'initializes with attributes' do

  end
end
