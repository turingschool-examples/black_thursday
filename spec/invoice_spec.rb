require_relative './spec_helper'

RSpec.describe Invoice do
  describe 'instantiation' do
    before :each do
      @se = SalesEngine.new({
        items: 'spec/fixtures/items.csv',
        merchants: 'spec/fixtures/merchants.csv',
        invoices: 'spec/fixtures/invoices.csv',
        customers: 'spec/fixtures/customers.csv',
        invoice_items: 'spec/fixtures/invoice_items.csv',
        transactions: 'spec/fixtures/transactions.csv'
        })
      @ivr = InvoiceRepository.new('spec/fixtures/invoices.csv', @se)
      @i = Invoice.new({
        :id          => 6,
        :customer_id => 7,
        :merchant_id => 8,
        :status      => :pending,
        :created_at  => Time.now.to_s,
        :updated_at  => Time.now.to_s
      }, @ivr)
    end

    it 'exists' do
      expect(@i).to be_a(Invoice)
    end

    it 'has attributes' do
      expect(@i.id).to eq(6)
      expect(@i.customer_id).to eq(7)
      expect(@i.merchant_id).to eq(8)
      expect(@i.status).to eq(:pending)
    end
  end

  describe 'methods' do
    it 'updates invoice status' do
      se = SalesEngine.new({
        items: 'spec/fixtures/items.csv',
        merchants: 'spec/fixtures/merchants.csv',
        invoices: 'spec/fixtures/invoices.csv',
        customers: 'spec/fixtures/customers.csv',
        invoice_items: 'spec/fixtures/invoice_items.csv',
        transactions: 'spec/fixtures/transactions.csv'
        })
      ivr = InvoiceRepository.new('spec/fixtures/invoices.csv', se)
      i = Invoice.new({
        :id          => 6,
        :customer_id => 7,
        :merchant_id => 8,
        :status      => :pending,
        :created_at  => Time.now.to_s,
        :updated_at  => Time.now.to_s
      }, ivr)

      attributes = {
        :status => :shipped
      }

      i.update_invoice(attributes)
      expect(i.id).to eq(6)
      expect(i.status).to eq(:shipped)
    end
  end
end
