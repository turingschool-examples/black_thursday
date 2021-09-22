require_relative 'spec_helper'
require 'Time'
require 'rspec'
require_relative '../lib/invoice'

describe Invoice do
  before(:each) do
    @invoice = Invoice.new({
                      :id          => '6',
                      :customer_id => '7',
                      :merchant_id => '8',
                      :status      => 'pending',
                      :created_at  => '2009-02-07',
                      :updated_at  => '2014-03-15',
                      })
  end

  it 'exists' do
    expect(@invoice).to be_an_instance_of(Invoice)
  end

  it 'attributes' do
    expect(@invoice.id).to eq(6)
    expect(@invoice.customer_id).to eq(7)
    expect(@invoice.merchant_id).to eq(8)
    expect(@invoice.status).to eq(:pending)
    expect(@invoice.created_at).to be_an_instance_of(Time)
    expect(@invoice.updated_at).to be_an_instance_of(Time)
  end
end
