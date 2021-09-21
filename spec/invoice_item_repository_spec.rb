# frozen_string_literal: true

require 'SimpleCov'
SimpleCov.start

require 'rspec'
require 'csv'
require 'BigDecimal'
require './lib/invoice_item_repository'

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
    it 'returns all invoice items with matching item id as an arry' do
      expect(@iir.find_all_by_item_id(263_539_664)).to include(@iir.all[5], @iir.all[388])
      expect(@iir.find_all_by_item_id(634_713_543)).to eq([])
    end
  end

  describe '#find_all_by_invoice_id' do
    it 'returns all invoice items with matching invoice id as an array' do
      expect(@iir.find_all_by_invoice_id(3)).to include(@iir.all[12], @iir.all[19])
      expect(@iir.find_all_by_invoice_id(754_234)).to eq([])
    end
  end

  describe '#create' do
    it 'it can create a new instance of invoice item' do
      item_id = 5
      invoice_id = 5
      quantity = 5
      unit_price = BigDecimal(20.99, 4)
      @iir.create(item_id, invoice_id, quantity, unit_price)

      expect(@iir.all.last).to be_a InvoiceItem
      expect(@iir.all.last.quantity).to eq(5)
    end
  end

  describe '#update' do
    it 'it can update an specific invoice item with given attributes' do
      expect(@iir.update(5, [5, 10.99])).to eq(@iir.all[4])
      expect(@iir.all[4].quantity).to eq(5)
      expect(@iir.all[4].unit_price).to eq(10.99)
    end
  end

  describe '#delete' do
    it 'can delete an invoice item' do
      deleted_item = @iir.all[6]

      expect(@iir.delete(7)).to eq(deleted_item)
      expect(@iir.find_by_id(7)).to be nil
    end
  end
end
