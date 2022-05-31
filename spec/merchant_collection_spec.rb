require "./lib/merchant_collection"

RSpec.describe MerchantCollection do
  before :each do
    @merchant_collection = MerchantCollection.new("./data/merchants.csv")
  end

  it 'exists & has attributes' do
    expect(@merchant_collection).to be_a(MerchantCollection)
    expect(@merchant_collection.all).to be_a(Array)
    expect(@merchant_collection.all.length).to eq(475)
  end

  it 'returns data from our merchant array' do
    expect(@merchant_collection.all.first.id).to eq("12334105")
    expect(@merchant_collection.all.last.name).to eq("CJsDecor")
  end

  it 'can find a merchant by id' do
    expect(@merchant_collection.find_by_id("12334105").first.name).to eq("Shopin1901")
    expect(@merchant_collection.find_by_id("12334189").first.name).to eq("JacquieMann")
    expect(@merchant_collection.find_by_id("12335080").first.name).to eq("HooksforBooks")
  end

  it 'can find a merchant by name' do
    expect(@merchant_collection.find_by_name("JacquieMann")).to be_a(Merchant)
  end

  it 'can find all names given the characters' do
    expect(@merchant_collection.find_all_by_name("ing").length).to eq(24)
    expect(@merchant_collection.find_all_by_name("iNg").length).to eq(24)
    expect(@merchant_collection.find_all_by_name("store").length).to eq(4)
    expect(@merchant_collection.find_all_by_name("sToRe").length).to eq(4)
    expect(@merchant_collection.find_all_by_name("Uniford").length).to eq(1)
    expect(@merchant_collection.find_all_by_name("unIFoRd").length).to eq(1)
    expect(@merchant_collection.find_all_by_name("uniford").first.id).to eq("12334174")
  end
end
