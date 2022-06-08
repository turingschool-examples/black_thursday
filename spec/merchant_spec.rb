require 'simplecov'
SimpleCov.start
require './lib/helper'

RSpec.describe Merchant do
  let!(:time) {Time.now}
  let!(:merchant) {Merchant.new({
    :id => 5,
    :name => "Turing School",
    :created_at => time,
    :updated_at => time
    })}

  it 'exists' do
    expect(merchant).to be_instance_of(Merchant)
  end

  it 'returns id' do
    expect(merchant.id).to eq(5)
  end

  it 'returns name' do
    expect(merchant.name).to eq("Turing School")
  end

  it "returns time created" do
    expect(merchant.created_at.strftime("%Y-%m-%d %H:%M")).to eq(time.strftime("%Y-%m-%d %H:%M"))
  end

end
