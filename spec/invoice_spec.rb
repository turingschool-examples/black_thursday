# frozen_string_literal: true

require 'SimpleCov'
SimpleCov.start

require 'rspec'
require './lib/invoice'

describe Invoice do
  before(:each) do
    @new_invoice = {
      id:           6,
      customer_id:  7,
      merchant_id:  8,
      status:       'pending',
      created_at:   Time.now.to_s,
      updated_at:   Time.now.to_s
    }
    @invoice = Invoice.new(@new_invoice)
  end

  it 'creates an instance of Invoice' do
    expect(@invoice).to be_a(Invoice)
  end

  describe '#id' do
    it 'returns the id' do
      expect(@invoice.id).to eq(6)
    end
  end

  describe '#customer_id' do
    it 'returns the customer_id' do
      expect(@invoice.customer_id).to eq(7)
    end
  end

  describe '#merchant_id' do
    it 'returns the merchant_id' do
      expect(@invoice.merchant_id).to eq(8)
    end
  end

  describe '#status' do
    it 'returns the status' do
      expect(@invoice.status).to eq('pending')
    end
  end

  describe '#created_at' do
    it 'returns the created_at' do
      expect(@invoice.created_at).to eq(@new_invoice[:created_at])
    end
  end

  describe '#updated_at' do
    it 'returns the updated_at' do
      expect(@invoice.updated_at).to eq(@new_invoice[:updated_at])
    end
  end

  describe '#update' do
    it 'updates the status' do
      expect(@invoice.update('returned')).to eq(@invoice)
      expect(@invoice.status).to eq('returned')
    end
  end
end
