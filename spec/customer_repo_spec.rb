require "CSV"
require "Rspec"
require_relative "../lib/customer_repo"

describe CustomerRepo do
  before :each do
    @cr = CustomerRepo.new('./data/customers.csv')
  end

  it 'is an instance of CustomerRepo' do
    expect(@cr).to be_a CustomerRepo
  end

  it "creates an array full of hashes from the csv" do
    expect(@cr.to_array).to be_a Array
    expect(@cr.to_array.empty?).to be false
  end

  it "#all" do
    expect(@cr.all).to be_a Array
    expect(@cr.all.empty?).to be false
    expect(@cr.all[0]).to be_a Customer
    expect(@cr.all.length).to eq 1000
  end

  it "#find_by_id" do
    expect(@cr.find_by_id(850)).to be_a Customer
    expect(@cr.find_by_id(850).first_name).to eq "Shane"
    expect(@cr.find_by_id(-1)).to eq nil
  end
end
