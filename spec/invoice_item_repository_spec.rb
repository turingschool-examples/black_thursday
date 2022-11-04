# frozen_string_literal: true

require 'rspec'
require 'csv'
require 'bigdecimal'
require './lib/invoice_item_repository'

describe InvoiceItemRepository do
  let(:data) { CSV.open './data/invoice_items_test.csv', headers: true, header_converters: :symbol }
  let(:iir) { InvoiceItemRepository.new(data, "SE") }
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
  describe 'inherited methods' do
    describe '#all' do
      it 'returns an array of all known InvoiceItem instances' do
        expect(iir.all).to be_a Array
        expect(iir.all).to eq(iir.repository)
      end
    end

    describe '#find_by_id' do
      it 'returns nil or a InvoiceItem instance that matches id' do
        expect(iir.find_by_id(2)).to eq(iir.repository[1])
        expect(iir.find_by_id(8)).to be nil
      end
    end

    describe '#update' do
      it 'updates the InvoiceItem instance that matches the id with the provided name' do
        iir.update('2',
                   {
                     quantity: 2,
                     unit_price: BigDecimal(11.69, 4)
                   })
        expect(iir.find_by_id(2).quantity).to eq(2)
        expect(iir.find_by_id(2).unit_price).to eq(BigDecimal(11.69, 4))
      end
    end

    describe '#delete' do
      it 'removes a InvoiceItem instance with the corresponding id' do
        iir.delete('2')
        expect(iir.repository.count).to eq(3)
        expect(iir.repository[2].id).to eq(4)
      end
    end
  end

  describe '#find_all_by_item_id' do
    it 'returns an array of all InvoiceItem instances that have a matching item_id' do
      ii1 = iir.repository[0]
      ii2 = iir.repository[1]
      ii3 = iir.repository[2]
      ii4 = iir.repository[3]
      expect(iir.find_all_by_item_id('000000000')).to eq([])
      expect(iir.find_all_by_item_id('263519844')).to eq([ii1])
      expect(iir.find_all_by_item_id(263454779)).to eq([ii2])
      expect(iir.find_all_by_item_id('263451719')).to eq([ii3])
      expect(iir.find_all_by_item_id(263542298)).to eq([ii4])
    end
  end

  describe '#find_all_by_invoice_id' do
    it 'returns an array of all InvoiceItem instances that have a matching invoice_id' do
      ii1 = iir.repository[0]
      ii2 = iir.repository[1]
      ii3 = iir.repository[2]
      ii4 = iir.repository[3]
      expect(iir.find_all_by_invoice_id('000000000')).to eq([])
      expect(iir.find_all_by_invoice_id('1')).to eq([ii1, ii2, ii3, ii4])
      expect(iir.find_all_by_invoice_id(1)).to eq([ii1, ii2, ii3, ii4])
    end
  end
end
