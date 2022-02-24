require 'rspec'
require './lib/invoice'

describe Invoice do
  describe '#initialize' do
    invoice = Invoice.new({
      :id => 6,
      :customer_id => 7,
      :merchant_id => 8,
      :status => "pending",
      :created_at => "12:30",
      :updated_at => "18:45"
      })

    it 'exists' do
      expect(invoice).to be_an_instance_of(Invoice)
    end

    it 'has its own id and customer and merchant ids' do
      expect(invoice.id).to eq(6)
      expect(invoice.customer_id).to eq(7)
      expect(invoice.merchant_id).to eq(8)
    end

    it 'has a status' do
      expect(invoice.status).to eq("pending")
    end

    it 'can tell you when it was created and updated' do
      expect(invoice.created_at).to eq("12:30")
      expect(invoice.updated_at).to eq("18:45")
    end

  end
end
