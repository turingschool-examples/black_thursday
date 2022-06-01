require 'simplecov'
SimpleCov.start
require './lib/merchant'
require "./lib/merchant_collection"

RSpec.describe MerchantCollection do
  before :each do
    @mc = MerchantCollection.new("./data/merchants.csv")
  end

  it 'exists & has attributes' do
    expect(@mc).to be_a(MerchantCollection)
    expect(@mc.all).to be_a(Array)
    expect(@mc.all.length).to eq(475)
  end

  it 'returns data from our merchant array' do
    expect(@mc.all.first.id).to eq("12334105")
    expect(@mc.all.first).to be_a(Merchant)
    expect(@mc.all.last.name).to eq("CJsDecor")
  end

  it 'can find a merchant by id' do
    expect(@mc.find_by_id("12334672")).to be_a(Merchant)
    expect(@mc.find_by_id("12334105").name).to eq("Shopin1901")
    expect(@mc.find_by_id("12335080").name).to eq("HooksforBooks")
    expect(@mc.find_by_id("12335807").id).to eq("12335807")
  end

  it 'can find a merchant by name' do
    expect(@mc.find_by_name("JacquieMann")).to be_a(Merchant)
    expect(@mc.find_by_name("JacquieMann").id).to eq("12334189")
  end

  it 'can find all names given the characters' do
    expect(@mc.find_all_by_name("ing").length).to eq(24)
    expect(@mc.find_all_by_name("iNg").length).to eq(24)
    expect(@mc.find_all_by_name("store").length).to eq(4)
    expect(@mc.find_all_by_name("sToRe").length).to eq(4)
    expect(@mc.find_all_by_name("uNIFoRd").length).to eq(1)
    expect(@mc.find_all_by_name("uniford").first.id).to eq("12334174")
  end

  it 'can create attributes' do
    attributes = {
                  id: 12337412,
                  name: "WingzandThingz"
                }
    expect(@mc.all.length).to eq(475)
    @mc.create(attributes)
    expect(@mc.all.length).to eq(476)
    expect(@mc.all.last.name).to eq("WingzandThingz")
  end

  it 'can update attributes' do
    attributes = {
                  name: "Random212",
                  updated_at: Time.now.to_s
                }

    expect(@mc.find_by_id("12337209").name).to eq("bizuteriaNYC")
    @mc.update("12337209", attributes)
    expect(@mc.find_by_id("12337209").name).to eq("Random212")
  end
end
