require_relative 'spec_helper'

RSpec.describe SalesEngine do
  it "exists" do
    se = SalesEngine.new

    expect(se).to be_a(SalesEngine)
  end

  it "has attributes" do
    se = SalesEngine.new

    expect(se.library.class).to eq(Hash)
    expect(se.library.keys.length).to eq(2)
    expect(se.library.values.length).to eq(2)
    expect(se.library.keys.first).to eq(:items)
    expect(se.library.keys.last).to eq(:merchants)
    expect(se.library.values.first).to eq("./data/items.csv")
    expect(se.library.values.last).to eq("./data/merchants.csv")
  end

  it "can return instances of its merchants" do
    se = SalesEngine.new
    merchants = se.merchants

    expect(merchants.class).to eq(Array)
    expect(merchants.length).to eq(475)

    data_validation = merchants.all? do |line|
      line.class == Hash
      line.keys.length == 4
      line.values.length == 4
    end

    expect(data_validation).to be(true)
  end

  it "can return instances of its items" do
    se = SalesEngine.new
    items = se.items

    expect(items.class).to eq(Array)
    expect(items.length).to eq(1367)

    data_validation = items.all? do |line|
      line.class == Hash
      line.keys.length == 7
      line.values.length == 7
    end

    expect(data_validation).to be(true)
  end
end
