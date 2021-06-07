require_relative 'spec_helper'
require_relative '../lib/invoice'
require 'csv'

RSpec.describe Invoice do
  before :each do
    @date = Time.now.strftime("%m/%d/%Y")
    @repo = double('repo')
    @attributes = {
      :id          => 6,
      :customer_id    => 7,
      :merchant_id => 8,
      :status      => "pending",
      :created_at  => @date,
      :updated_at  => @date,
      }
    @i = Invoice.new(@attributes, @repo)
  end

  it 'exists' do
    expect(@i).to be_a(Invoice)
  end

  it 'has attributes' do
    expect(@i.id).to eq(6)
    expect(@i.customer_id).to eq(7)
    expect(@i.merchant_id).to eq(8)
    expect(@i.status).to eq(:pending)
    expect(@i.created_at).to eq(Date.strptime(@date, "%m/%d/%Y"))
    expect(@i.updated_at).to eq(Date.strptime(@date, "%m/%d/%Y"))
  end

  it 'can create new invoice' do
    allow(@repo).to receive(:next_highest_id).and_return(4)
    expect(Invoice.create_new({customer_id: 2, merchant_id: 104, status:
    "pending"}, @repo)).to be_an_instance_of(Invoice)
  end

  it 'can update existing invoice' do
    @i.update_invoice({status: :shipped})
    expect(@i.id).to eq(6)
    expect(@i.status).to eq(:shipped)
  end

end
