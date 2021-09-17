# frozen_string_literal: true

require 'SimpleCov'
SimpleCov.start

require 'rspec'
require 'csv'
require './lib/invoice_repository'
require './lib/invoice'


describe InvoiceRepository do
  before(:each) do
    @ir = InvoiceRepository.new('./data/invoices.csv')
  end

  it 'exists' do
    expect(@ir).to be_a InvoiceRepository
  end

  describe 'all' do
    it 'returns all invoices' do

      expect(@ir.all).to be_a(Array)

      @ir.all.each do |invoice|
        expect(invoice).to be_a(Invoice)
      end
    end
  end

  describe '#find_by_id' do
    it 'can find an invoice with given id' do
      expect(@ir.find_by_id(35)).to eq(@ir.all[34])
      expect(@ir.find_by_id(623_425)).to be nil
    end
  end

  describe '#find_all_by_customer_id' do
    it 'returns matches for customer id in array form' do
      expect(@ir.find_all_by_customer_id(5)).to include(@ir.all[21])
      expect(@ir.find_all_by_customer_id(5)).to be_a(Array)
    end

    it 'returns an empty array if no customers match the id' do
      expect(@ir.find_all_by_customer_id(1234)).to eq([])
    end
  end

  describe '#find_all_by_merchant_id' do
    it 'returns matches for merchant id in array form' do
      expect(@ir.find_all_by_merchant_id(123_343_89)).to include(@ir.all[5])
      expect(@ir.find_all_by_merchant_id(123_343_89)).to be_a(Array)
    end

    it 'returns an empty array if no merchants match the id' do
      expect(@ir.find_all_by_merchant_id(632_540_91)).to eq([])
    end
  end

  describe '#find_all_by_status' do
    it 'returns matches for given status in array form' do
      expect(@ir.find_all_by_status("returned")).to include(@ir.all[24])
      expect(@ir.find_all_by_status("returned")).to be_a(Array)
    end

    it 'returns an empty array if no invoices match the status' do
      expect(@ir.find_all_by_status("gone for good")).to eq([])
    end
  end

  describe '#create' do
    it 'creates an invoice with the given attributes' do
      customer_id = 72
      merchant_id = 324_602_09
      status = 'pending'
      @ir.create(customer_id, merchant_id, status)

      expect(@ir.all.last).to be_a(Invoice)
      expect(@ir.all.last.merchant_id).to eq(324_602_09)
    end
  end

  describe '#update' do
    it 'updates a specific invoice with the provided attribute' do

      expect(@ir.update(63, "returned")).to eq(@ir.all[62])
      expect(@ir.all[62].status).to eq("returned")
    end
  end

  describe '#delete' do
    it 'removes the given invoice from the invoice repo' do
      deleted_invoice = @ir.all[51]

      expect(@ir.delete(52)).to eq(deleted_invoice)
      expect(@ir.find_by_id(52)).to be nil
    end
  end
end
