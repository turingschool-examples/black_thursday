require 'rspec'
require './lib/invoice'

RSpec.describe Invoice do
  before (:each) do
    @invoice = Invoice.new ({
      :id => 1,
      :customer_id => 7,
      :merchant_id => 8,
      :status => "pending",
      :created_at => Date.today.to_s,
      :updated_at => Date.today.to_s
      })
    end

    describe "instantiation" do
      it "exists" do
        expect(@invoice).to be_a(Invoice)
      end

      it "has readable attributes" do
        expect(@invoice.id).to eq(1)
        expect(@invoice.customer_id).to eq(7)
        expect(@invoice.merchant_id).to eq(8)
        expect(@invoice.status).to eq(:pending)
        expect(@invoice.created_at).to eq(Date.today.to_s)
        expect(@invoice.updated_at).to eq(Date.today.to_s)
      end
    end 
  end
