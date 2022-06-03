require './lib/invoice'

RSpec.describe Invoice do
  before :each do
    @my_invoice = Invoice.new({
      :id => 6,
      :customer_id => 7,
      :merchant_id => 8,
      :status      => 'pending',
      :created_at  => '1994-05-07 23:38:43 UTC',
      :updated_at  => '2016-01-11 11:30:35 UTC',
      })
  end

  describe '#initialize' do
    it 'is an invoice' do
      expect(@my_invoice).to be_a Invoice
    end

    it 'has an id' do
      expect(@my_invoice.id).to eq 6
    end

    it 'has a customer_id' do
      expect(@my_invoice.customer_id).to eq 7
    end

    it 'has a merchant_id' do
      expect(@my_invoice.merchant_id).to eq 8
    end

    it 'has a status' do
      expect(@my_invoice.status).to eq 'pending'
    end

    it 'has a created_at time' do
      expect(@my_invoice.created_at).to eq '1994-05-07 23:38:43 UTC'
    end

    it 'has an update_at time' do
      expect(@my_invoice.updated_at).to eq '2016-01-11 11:30:35 UTC'
    end
  end
end
