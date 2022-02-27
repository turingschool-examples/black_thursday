require_relative '../lib/invoice'
require_relative 'spec_helper'
require 'pry'

  RSpec.describe Invoice do
    before (:each) do
    @invoice = Invoice.new({
      :id          => 6,
      :customer_id => 7,
      :merchant_id => 8,
      :status      => "pending",
      :created_at  => Time.now,
      :updated_at  => Time.now,
    })
  end

    it 'exists' do
      expect(@invoice).to be_a(Invoice)
    end

    it 'can read attributes' do
      expect(@invoice.customer_id).to eq(7)
      expect(@invoice.status).to eq("pending")
    end
end
