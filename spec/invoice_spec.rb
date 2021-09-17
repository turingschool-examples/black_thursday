require 'rspec'
require './lib/invoice'

describe Invoice do
  describe '#initialize' do
    before do
      @i = Invoice.new({
            :id          => 6,
            :customer_id => 7,
            :merchant_id => 8,
            :status      => 'pending',
            :created_at  => Time.now.to_s,
            :updated_at  => Time.now.to_s
          })
    end

    it 'is and instance of Invoice' do
      expect(@i).to be_an_instance_of Invoice
    end

    it 'has an id' do
      expect(@i.id).to eq(6)
    end

    it 'has a customer_id' do
      expect(@i.customer_id).to eq(7)
    end

    it 'has a merchant_id' do
      expect(@i.merchant_id).to eq(8)
    end

    it 'has a status' do
      expect(@i.status).to eq(:pending)
    end

    it 'has a created_at and updated at time' do
      expect(@i.created_at).to eq(@i.created_at)
      expect(@i.updated_at).to eq(@i.created_at)
    end
  end
end
