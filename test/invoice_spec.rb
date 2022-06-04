require_relative './spec_helper'

RSpec.describe Invoice do
  before :each do
    @i = Invoice.new({
    :id          => 6,
    :customer_id => 7,
    :merchant_id => 8,
    :status      => "pending",
    :created_at  => Time.now,
    :updated_at  => Time.now,
    })
  end

  it 'exists' do
    expect(@i).to be_a Invoice
  end

  it 'has an id' do
    expect(@i.id).to eq(6)
  end

  it 'has a customer id' do
    expect(@i.customer_id).to eq(7)
  end

  it 'has a merchant id' do
    expect(@i.merchant_id).to eq(8)
  end

  xit 'has a status' do
    expect(@i.status).to eq("pending")
  end

  xit 'has a created at time stamp' do
    expect(@i.created_at).to eq Time.parse("2015-07-10 00:00:00 -0600")
    expect(@i.created_at.class).to eq(Time)
  end

  xit 'has an updated at time stamp' do
    expect(@i.updated_at).to be_instance_of(Time)
  end
end
