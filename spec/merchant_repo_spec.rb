require 'rspec'
require './lib/merchant_repo'

describe @mr do
  before(:each) do
    @mr = MerchantRepo.new
  end

  it 'exists' do

    expect(@mr).to be_an_instance_of(MerchantRepo)
  end

  it '#all' do

    expect(@mr.all).to be_an(Array)
  end

  it "#find_by_id" do
    expect(@mr.find_by_id(12334105).name).to eq("Shopin1901")
  end

  it "#find_by_name" do
    expect(@mr.find_by_name("Urcase17").id).to eq(12334144)
  end

  it "#find_all_by_name" do
    expect(@mr.find_all_by_name("nate brown store")).to eq([])
    expect(@mr.find_all_by_name("neart").first.name).to eq("JamesCByrneART")
    expect(@mr.find_all_by_name("neart")[1].name).to eq("GlassFigurineArt")
  end

  xit "#create(attributes)" do
    expect(@mr.create({:name => "John Napier"})).to eq()
  end
end
