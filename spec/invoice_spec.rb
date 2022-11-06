# frozen_string_literal: true

require './lib/invoice'

RSpec.describe Invoice do
  let(:ir) { 'Empty_IR' }
  describe '#initialize' do
    it 'has readable attributes' do
      time1 = Time.now
      time2 = Time.now
      data = {
                id:          6,
                customer_id: 7,
                merchant_id: 8,
                status:      'pending',
                created_at:   time1,
                updated_at:   time2
              }
      invoice = Invoice.new(data, ir)

      expect(invoice.id).to eq 6
      expect(invoice.customer_id).to eq 7
      expect(invoice.merchant_id).to eq 8
      expect(invoice.status).to eq :pending
      expect(invoice.created_at).to eq time1
      expect(invoice.updated_at).to eq time2
    end
  end

  describe '#update' do
    it 'can change the updated_at to the current Time' do
      time1 = Time.now
      time2 = Time.now
      data = {
                id:           6,
                customer_id: 7,
                merchant_id: 8,
                status:     'pending',
                created_at:  time1,
                updated_at:  time2
             }
      invoice = Invoice.new(data, ir)

      expect(invoice.update({status: :shipped})).to be_within(0.5).of Time.now
      expect(invoice.status).to eq :shipped
    end
  end

  describe '#_transactions' do
    it 'returns a list of transactions associated with the invoice' do
      invoice_repo = double('InvoiceRepo')
      engine = double('engine')
      trans_repo = double('TransactionRepo')
      invoice = Invoice.new({
                              id: 1,
                              customer_id: 1,
                              merchant_id: 1,
                              status: 'shipped',
                              created_at: Time.now,
                              updated_at: Time.now
                            }, invoice_repo)
      allow(invoice_repo).to receive(:engine).and_return(engine)
      allow(engine).to receive(:transactions).and_return(trans_repo)
      allow(trans_repo).to receive(:find_all_by_invoice_id).and_return(['transaction1', 'transaction2'])
      expect(invoice._transactions).to eq ['transaction1', 'transaction2']
    end
  end

  describe '#paid?' do
    it 'returns a boolean indicating if a transaction was successful' do
      transaction1 = double('transaction1')
      transaction2 = double('transaction2')
      invoice_repo = double('InvoiceRepo')
      invoice = Invoice.new({
                              id: 1,
                              customer_id: 1,
                              merchant_id: 1,
                              status: 'shipped',
                              created_at: Time.now,
                              updated_at: Time.now
                            }, invoice_repo)
      allow(transaction1).to receive(:result).and_return(:success)
      allow(transaction2).to receive(:result).and_return(:failed)
      allow(invoice).to receive(:_transactions).and_return([transaction1, transaction2])
      expect(invoice.paid?).to eq(true)
    end
  end

  describe '#_invoice_items' do
    it 'returns an array of invoice_items associated with an invoice' do
      invoice_repo = double('InvoiceRepo')
      engine = double('engine')
      invoice_item_repo = double('InvoiceItemRepo')
      invoice = Invoice.new({
                              id: 1,
                              customer_id: 1,
                              merchant_id: 1,
                              status: 'shipped',
                              created_at: Time.now,
                              updated_at: Time.now
                            }, invoice_repo)
      allow(invoice_repo).to receive(:engine).and_return(engine)
      allow(engine).to receive(:invoice_items).and_return(invoice_item_repo)
      allow(invoice_item_repo).to receive(:find_all_by_invoice_id).and_return(['invoice_item1', 'invoice_item2'])
      expect(invoice._invoice_items).to eq ['invoice_item1', 'invoice_item2']
    end
  end
end
