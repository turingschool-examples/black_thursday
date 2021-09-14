require 'rspec'
require './lib/invoice'

describe 'Invoice' do
  describe '#initialize' do
    before do
      @i = Invoice.new({
            :id          => 6,
            :customer_id => 7,
            :merchant_id => 8,
            :status      => "pending",
            :created_at  => Time.now,
            :updated_at  => Time.now,
          })
    end

    it 'is and instance of Invoice' do
      expect(@i).to be_an_instance_of Invoice
    end

    it 'has an id' do
      expect(@i.id).to eq(6)
    end
  end
end
