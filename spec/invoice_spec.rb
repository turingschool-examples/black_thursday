require 'rspec'
require './lib/invoice'

describe Invoice do
  describe '#initialize' do
    invoice = Invoice.new({
      :id => 6,
      :customer_id => 7,
      :merchant_id => 8,
      :status => "pending",
      :created_at => Time.now,
      :updated_at => Time.now
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

    xit 'can tell you when it was created and updated' do
      expect(invoice.created_at).to eq(Time.now)
      expect(invoice.updated_at).to eq(Time.now)
    end

  end
end
