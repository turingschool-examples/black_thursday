require 'bigdecimal'
require_relative 'spec_helper'

RSpec.describe Invoice do

  before(:each) do
    @paths = {
      :items => "./data/items.csv",
      :merchants => "./data/merchants.csv",
      :invoices => "./data/invoices.csv"
    }
    @se = SalesEngine.from_csv(@paths)
    @ir = @se.invoices
  end

  it 'exists' do
    i = Invoice.new({
    :id          => 3452,
    :customer_id        => 679,
    :merchant_id => 12335690,
    :status  => :pending,
    :created_at  => Time.now,
    :updated_at  => Time.now,
    }, @ir)

    expect(i).to be_a(Invoice)
  end

  it 'has attributes' do
    time_stub = '2021-05-30 11:30:51 -0500'
    allow(Time).to receive(:now).and_return(time_stub)

    i = Invoice.new({
    :id          => 3452,
    :customer_id        => 679,
    :merchant_id => 12335690,
    :status  => :pending,
    :created_at  => Time.now,
    :updated_at  => Time.now,
    }, @ir)

    expect(i.id).to eq(3452)
    expect(i.customer_id).to eq(679)
    expect(i.merchant_id).to eq(12335690)
    expect(i.status).to eq(:pending)
    expect(i.created_at.to_s).to eq(Time.now)
    expect(i.updated_at.to_s).to eq(Time.now)
  end

  it 'stores its states in a hash' do
    time_stub = '2021-05-30 11:30:51.343158 -050'
    allow(Time).to receive(:now).and_return(time_stub)

    i = Invoice.new({
    :id          => 3452,
    :customer_id        => 679,
    :merchant_id => 12335690,
    :status  => :pending,
    :created_at  => Time.now,
    :updated_at  => Time.now,
    }, @ir)
    i_hash = i.to_hash

    expect(i_hash).to be_a(Hash)
    expect(i_hash.keys.length).to eq(6)
    expect(i_hash.values.length).to eq(6)
    expect(i_hash[:id]).to eq(i.id)
    expect(i_hash[:customer_id]).to eq(i.customer_id)
    expect(i_hash[:merchant_id]).to eq(i.merchant_id)
    expect(i_hash[:status]).to eq(i.status)
    expect(i_hash[:created_at]).to eq(i.created_at)
    expect(i_hash[:updated_at]).to eq(i.updated_at)
  end
end
