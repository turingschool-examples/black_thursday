# frozen_string_literal: true

require 'rspec'
require 'csv'
require 'bigdecimal'
require './lib/invoice_item_repository'

describe InvoiceItemRepository do
  let(:data) { CSV.open './data/invoice_items_test.csv', headers: true, header_converters: :symbol }
  let(:iir) { InvoiceItemRepository.new(data) }
  let(:time1) { Time.now }
  let(:time2) { Time.now }

  describe '#initialize' do
    it 'instantiates with appropriate attributes' do
      ii1 = iir.repository[0]
      ii2 = iir.repository[1]
      ii3 = iir.repository[2]
      ii4 = iir.repository[3]
      expect(iir).to be_a InvoiceItemRepository
      expect(iir.repository).to eq([ii1, ii2, ii3, ii4])
    end
  end

  describe '#create' do
    it 'creates an InvoiceItem and adds object to @repository' do
      iir.create(
        {
          id: 6,
          item_id: 7,
          invoice_id: 8,
          quantity: 1,
          unit_price: BigDecimal(10.99, 4),
          created_at: time1,
          updated_at: time2
        }
      )
      expect(iir.repository[4].id).to eq(6)
      expect(iir.repository[4].item_id).to eq(7)
      expect(iir.repository[4].invoice_id).to eq(8)
      expect(iir.repository[4].quantity).to eq(1)
      expect(iir.repository[4].unit_price).to eq(BigDecimal(10.99, 4))
      expect(iir.repository[4].created_at).to eq(time1)
      expect(iir.repository[4].updated_at).to eq(time2)
    end
  end

  describe '#all' do
    it 'returns an array of all known InvoiceItem instances' do
      expect(iir.all).to be_a Array
      expect(iir.all).to eq(iir.repository)
    end
  end

  describe '#find_by_id' do
    it 'returns nil or a InvoiceItem instance that matches id' do
      expect(iir.find_by_id('2')).to eq(iir.repository[1])
      expect(iir.find_by_id('8')).to be nil
    end
  end
end
