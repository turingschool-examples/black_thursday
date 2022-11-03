# frozen_string_literal: true

require './lib/invoice'

RSpec.describe Invoice do
  let(:ir) { 'Empty_IR' }
  describe '#initialize' do
    it 'has readable attributes' do
      time1 = Time.now
      time2 = Time.now
      data = {
                id:          6,
                customer_id: 7,
                merchant_id: 8,
                status:      'pending',
                created_at:   time1,
                updated_at:   time2
              }
      invoice = Invoice.new(data, ir)

      expect(invoice.id).to eq 6
      expect(invoice.customer_id).to eq 7
      expect(invoice.merchant_id).to eq 8
      expect(invoice.status).to eq 'pending'
      expect(invoice.created_at).to eq time1
      expect(invoice.updated_at).to eq time2
    end
  end

  describe '#update' do
    it 'can change the updated_at to the current Time' do
      time1 = Time.now
      time2 = Time.now
      data = {
                id:           6,
                customer_id: 7,
                merchant_id: 8,
                status:     'pending',
                created_at:  time1,
                updated_at:  time2
             }
      invoice = Invoice.new(data, ir)

      expect(invoice.update({status: 'shipped'})).to be_within(0.5).of Time.now
      expect(invoice.status).to eq 'shipped'
    end
  end
end
