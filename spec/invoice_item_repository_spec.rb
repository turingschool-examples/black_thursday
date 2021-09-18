# frozen_string_literal: true

require 'SimpleCov'
SimpleCov.start

require 'rspec'
require 'csv'
require './lib/invoice_item_repository'
require './lib/invoice_item'

describe InvoiceItemRepository do
  before(:each) do
    invoice_items = './data/invoice_items.csv'
    @iir = InvoiceItemRepository.new(invoice_items)
  end

  it 'is an instance of an InvoiceItemRepository' do
    expect(@iir).to be_a(InvoiceItemRepository)
  end

  describe '#all' do
    it 'returns all InvoiceItem instances in an array' do
      expect(@iir.all).to be_a(Array)

      @iir.all.each do |invoice_item|
        expect(invoice_item).to be_a(InvoiceItem)
      end
    end
  end

  describe '#find_by_id' do
    it 'finds an invoice item by id, or nil if there is no match' do
      expect(@iir.find_by_id(364)).to eq(@iir.all[363])
      expect(@iir.find_by_id(92_532)).to be nil
    end
  end

  describe '#find_all_by_item_id' do
    it 'returns all invoice items that have matching item id, or empty array otherwise' do
      expect(@iir.find_all_by_item_id(263_539_664)).to include(@iir.all[5], @iir.all[388])
      expect(@iir.find_all_by_item_id(634_713_543)).to eq([])
    end
  end

  describe '#find_all_by_invoice_id' do
    it 'returns all invoice items that have matching invoice id, or empty array otherwise' do
      expect(@iir.find_all_by_invoice_id(3)).to include(@iir.all[12], @iir.all[19])
      expect(@iir.find_all_by_invoice_id(754_234)).to eq([])
    end
  end
end
