require 'rspec'
require './lib/merchant_repo'

describe @mr do
  before(:each) do
    @mr = MerchantRepo.new('./data/merchants.csv')
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

  it '#find_highest_id' do
    expect(@mr.find_highest_id).to be >= 12337411
  end

  it "#create(attributes)" do
    @mr.create({:name => "John N."})
    expect(@mr.all.last.name).to eq("John N.")
  end

  it "#update(attributes)" do
    @mr.create({:name => "John N."})
    @mr.update(12337413, {:name => "Jean N."})
    expect(@mr.all[476].name).to eq("Jean N.")
  end

  it "#delete(id)" do
    @mr.create({:name => "John N."})
    @mr.delete(12337413)

    expect(@mr.find_by_id(12337413)).to eq(nil)
  end
end
