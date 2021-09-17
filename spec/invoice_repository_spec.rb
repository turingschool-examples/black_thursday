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
end
