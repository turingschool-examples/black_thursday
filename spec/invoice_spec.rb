# frozen_string_literal: true

# Invoice Test spec
require_relative '../lib/invoice'
require 'pry'

RSpec.describe 'Iteration 2' do
  context 'Invoices' do
    before(:each) do
      @i = Invoice.new({
                         id: 6,
                         customer_id: 7,
                         merchant_id: 8,
                         status: 'pending',
                         created_at: '2022-02-27 14:52:16 UTC',
                         updated_at: '2022-02-27 14:52:16 UTC'
                       })
    end

    it 'exists' do
      expect(@i).to be_an(Invoice)
    end

    it '#has attributes' do
      expect(@i.id).to eq(6)
      expect(@i.customer_id).to eq(7)
      expect(@i.merchant_id).to eq(8)
      expect(@i.status).to eq(:pending)
      expect(@i.created_at).to be_an_instance_of(Time)
      expect(@i.updated_at).to be_an_instance_of(Time)
    end
  end
end
