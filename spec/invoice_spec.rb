require_relative 'spec_helper'
require_relative '../lib/invoice'
require 'csv'

RSpec.describe Invoice do
  before :each do
    @i = Invoice.new({
      :id          => 6,
      :customer_id    => 7,
      :merchant_id => 8,
      :status      => "pending",
      :created_at  => "2021-06-04",
      :updated_at  => "2021-06-04",
      }, nil)
  end

  it 'exists' do
    expect(@i).to be_a(Invoice)
  end

  it 'has attributes' do
    expect(@i.id).to eq(6)
    expect(@i.customer_id).to eq(7)
    expect(@i.merchant_id).to eq(8)
    expect(@i.status).to eq("pending")
    expect(@i.created_at).to eq("2021-06-04")
    expect(@i.updated_at).to eq("2021-06-04")
  end

end
