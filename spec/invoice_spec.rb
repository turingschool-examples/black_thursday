require './lib/invoice'

describe Invoice do
  describe '#initialize' do
    it 'has readable attributes' do
      data = {
              :id          => 6,
              :customer_id => 7,
              :merchant_id => 8,
              :status      => "pending",
              :created_at  => Time.now,
              :updated_at  => Time.now,
              }
      invoice = Invoice.new(data)

      expect(invoice.id).to eq 6
      expect(invoice.customer_id).to eq 7
      expect(invoice.merchant_id).to eq 8
      expect(invoice.status).to eq "pending"
      expect(invoice.created_at).to eq ?
      expect(invoice.updated_at).to eq ?
    end
  end
end