# frozen_string_literal: true

require 'rspec'
require 'csv'
require './lib/invoice_item_repository'

describe InvoiceItemRepository do
  let(:data) { CSV.open './data/invoice_items_test.csv', headers: true, header_converters: :symbol }
  let(:iir) { InvoiceItemRepository.new(data) }

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
end
