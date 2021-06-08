require_relative 'spec_helper'

RSpec.describe Invoice do
  before :each do
    @invoice_data = {
                      :id => 6,
                      :customer_id => 7,
                      :merchant_id => 8,
                      :status => "pending",
                      :created_at => Time.now,
                      :updated_at => Time.now
                    }
    @invoice = Invoice.new(@invoice_data)
  end

  describe 'instantiation' do
    it 'exists' do
      expect(@invoice).to be_an(Invoice)
    end

    it 'has attributes' do
      expect(@invoice_data).to be_a(Hash)
      expect(@invoice.id).to eq(6)
      expect(@invoice.customer_id).to eq(7)
      expect(@invoice.merchant_id).to eq(8)
      expect(@invoice.status).to eq("pending")
      expect(@invoice.created_at).to be_a(Time)
      expect(@invoice.updated_at).to be_a(Time)
    end
  end
end
