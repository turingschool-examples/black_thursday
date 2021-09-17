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
    end
  end
end
