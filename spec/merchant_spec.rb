require 'pry'
require 'csv'
require './lib/merchant'

RSpec.describe Merchant do

  before(:each) do
    @m = Merchant.new({:id => 5, :name => "Turing School", :created_at => 12/12/12, :updated_at => 2/22/22})
  end

  it 'exists' do
    expect(@m).to be_an_instance_of(Merchant)
  end

  it 'has retreivable attributes' do
    expect(@m.id).to eq(5)
    expect(@m.name).to eq("Turing School")
    expect(@m.created_at).to eq(12/12/12)
    expect(@m.updated_at).to eq(2/22/22)
  end


end
