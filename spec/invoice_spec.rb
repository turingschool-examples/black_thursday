require 'rspec'
require './lib/invoice'

RSpec.describe Invoice do
  before(:each) do
    @invoice = Invoice.new({id: "1",
                          customer_id: "1",
                          merchant_id: "12335938",
                          status: "pending",
                          created_at: "2009-02-07",
                          updated_at: "2014-03-15"},
                          self)
  end
  describe 'instantiation' do
    it 'exists' do

      expect(@invoice).to be_a(Invoice)
    end

    it 'has readable attributes' do

      expect(@invoice.id).to eq(1)
      expect(@invoice.customer_id).to eq(1)
      expect(@invoice.merchant_id).to eq(12335938)
      expect(@invoice.status).to eq("pending")
      expect(@invoice.created_at).to eq("2009-02-07")
      expect(@invoice.updated_at).to eq("2014-03-15")
      expect(@invoice.repo).to eq(self)
    end
  end

  describe 'has a method that' do
    it 'can update the updated_at time' do
      expect(@invoice.updated_at).to eq("2014-03-15")

      @invoice.update_time

      expect(@invoice.updated_at.to_i).to eq(Time.now.to_i)
    end

    it 'can change the existing status' do
      expect(@invoice.status).to eq("pending")

      @invoice.change_status("LOST AT SEA")

      expect(@invoice.status).to eq("LOST AT SEA")
    end
  end
end
