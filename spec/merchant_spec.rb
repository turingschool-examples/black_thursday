require_relative 'spec_helper'
require "Rspec"
require_relative "../lib/merchant"

describe Merchant do
  before :each do
    @m = Merchant.new({
                      :id => '5',
                      :name => 'Turing School',
                      :created_at  => '2016-01-11',
                      :updated_at  => '2007-06-04'
                      })
  end

  it 'is a Merchant' do
    expect(@m).to be_a Merchant
  end

  it '#id' do
    expect(@m.id).to eq 5
  end

  it '#name' do
    expect(@m.name).to eq  'Turing School'
  end
end
