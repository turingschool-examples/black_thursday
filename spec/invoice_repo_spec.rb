# frozen_string_literal: true

require './lib/invoice_repo'
require './lib/invoice'
require 'CSV'

RSpec.describe InvoiceRepo do
  let(:data){ CSV.readlines('./data/invoices_test.csv', headers: true, header_converters: :symbol) }
  let(:engine) { 'Empty_SE' }
  let(:ir) { InvoiceRepo.new(data, engine) }
  let(:invoice1) { ir.repository[0] }
  let(:invoice2) { ir.repository[1] }
  let(:invoice3) { ir.repository[2] }
  let(:invoice4) { ir.repository[3] }
  let(:invoice5) { ir.repository[4] }

  describe '#initialize' do
    it 'exists' do
      expect(ir).to be_a InvoiceRepo
    end
  end

  describe '#all' do
    it 'returns an array of all known Invoice instances' do
      expect(ir.all).to eq [invoice1, invoice2, invoice3, invoice4, invoice5]
    end
  end

  describe '#find_by_id' do
    it 'returns either nil or an instance of Invoice with matching id' do
      expect(ir.find_by_id(3)).to eq invoice3
      expect(ir.find_by_id(8)).to eq nil
    end
  end

  describe '#find_by_customer_id' do
    it 'returns either [] or one or more instances of Invoice with matching customer id' do
      expect(ir.find_by_customer_id(1)).to eq [invoice1, invoice2, invoice3, invoice4, invoice5]
    end
  end

  describe '#find_by_merchant_id' do
    it 'returns either [] or one or more instances of Invoice with matching merchant id' do
      expect(ir.find_by_merchant_id(12_335_938)).to eq [invoice1]
      expect(ir.find_by_merchant_id(33_333_333)).to eq []
    end
  end

  describe '#find_all_by_status' do
    it 'returns [] or one or more instances of Invoice with matching status' do
      expect(ir.find_all_by_status('pending')).to eq [invoice1, invoice4, invoice5]
      expect(ir.find_all_by_status('shipped')).to eq [invoice2, invoice3]
    end
  end

  describe '#create' do
    it 'creates an Invoice with the provided attributes, new id is current highest + 1' do
      expect(ir.create({
                        customer_id:         7,
                        merchant_id:         8,
                        status:      'pending',
                        created_at:   Time.now,
                        updated_at:   Time.now
                       }).id).to eq '6'
    end
  end

  describe '#update' do
    it 'updates Invoice with corresponding id with the provided attributes' do
      expect(ir.repository[0].status).to eq 'pending'
      ir.update('1', { status: 'shipped' })
      expect(ir.repository[0].status).to eq 'shipped'
      expect(ir.repository[0].updated_at).to be_within(0.5).of Time.now
    end
  end

  describe '#delete' do
    it 'deletes the Invoice instance with corresponding id' do
      ir.delete('1')
      expect(ir.repository.count).to eq(4)
      expect(ir.repository[0].id).to eq('2')
    end
  end
end
