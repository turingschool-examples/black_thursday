require 'csv'
require_relative '../lib/sales_engine'
require "spec_helper_2"

RSpec.describe SalesEngine do
  it 'exists' do
    expect(engine).to be_a (SalesEngine)
  end

  it 'has child instances' do
    expect(engine.items).to be_a (ItemRepository)
    expect(engine.merchants).to be_a (MerchantRepository)
  end
  it 'can analyze' do
    expect(engine.analyst).to be_an_instance_of(SalesAnalyst)
  end
end
