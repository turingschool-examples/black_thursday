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
    expect(@i.status).to eq(:pending)
    expect(@i.created_at).to eq("2021-06-04")
    expect(@i.updated_at).to eq("2021-06-04")
  end

  it 'creates new invoice' do
    allow(@repo).to receive(:next_highest_id).and_return(4)
    expect(Invoice.create_new({customer_id: 2, merchant_id: 104, status:
    "pending"}, @repo)).to be_an_instance_of(Invoice)
  end

  xit 'can only update status and nothing else' do
      attributes_1 = {status: :success}
      attributes_2 = {
        id: 50,
        customer_id: 22,
        merchant_id: 200,
        created_at: Time.now
      }



  end
end
