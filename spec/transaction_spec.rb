require_relative './spec_helper'

RSpec.describe Transaction do
  describe 'instantiation' do
    it 'exists' do
      se = SalesEngine.new({
        items: 'spec/fixtures/items.csv',
        merchants: 'spec/fixtures/merchants.csv',
        invoices: 'spec/fixtures/invoices.csv',
        customers: 'spec/fixtures/customers.csv',
        invoice_items: 'spec/fixtures/invoice_items.csv',
        transactions: 'spec/fixtures/transactions.csv'
        })
      t = Transaction.new({
        :id => 6,
        :invoice_id => 8,
        :credit_card_number => "4242424242424242",
        :credit_card_expiration_date => "0220",
        :result => "success",
        :created_at => Time.now,
        :updated_at => Time.now
        }, se)

        expect(t).to be_a(Transaction)
    end

    it 'has attributes' do
      se = SalesEngine.new({
        items: 'spec/fixtures/items.csv',
        merchants: 'spec/fixtures/merchants.csv',
        invoices: 'spec/fixtures/invoices.csv',
        customers: 'spec/fixtures/customers.csv',
        invoice_items: 'spec/fixtures/invoice_items.csv',
        transactions: 'spec/fixtures/transactions.csv'
        })

      t = Transaction.new({
        :id => 6,
        :invoice_id => 8,
        :credit_card_number => "4242424242424242",
        :credit_card_expiration_date => "0220",
        :result => "success",
        :created_at => Time.now.to_s,
        :updated_at => Time.now.to_s
        }, se)

        expect(t.id).to eq(6)
        expect(t.invoice_id).to eq(8)
        expect(t.credit_card_number).to eq("4242424242424242")
        expect(t.credit_card_expiration_date).to eq("0220")
        expect(t.result).to eq(:success)
      end
    end
  end
