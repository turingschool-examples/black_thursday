require 'simplecov'
SimpleCov.start
require './lib/helper'

RSpec.describe InvoiceRepository do
  let!(:sales_engine) {SalesEngine.from_csv({
    :items     => "./data/items.csv",
    :merchants => "./data/merchants.csv"
  })}
  let!(:merchant_repository) {sales_engine.merchants}
  let!(:merchant) {merchant_repository.create(Merchant.new({
    :id => 5,
    :name => "Turing School"
  }))}

  it 'exists' do
    expect(merchant_repository).to be_instance_of(Merchant)
  end

  it 'returns id' do
    expect(merchant.id).to eq(5)
  end

  it 'returns name' do
    expect(merchant.name).to eq("Turing School")
  end

end
