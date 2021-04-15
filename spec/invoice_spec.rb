require 'rspec'
require './lib/invoice'

describe Invoice do
  describe '#initialize' do
    it 'exists' do
      i = Invoice.new({
        :id          => 6,
        :customer_id => 7,
        :merchant_id => 8,
        :status      => "pending",
        :created_at  => Time.now,
        :updated_at  => Time.now,
      })

      expect(i).is_a? Invoice
    end
  end
end
