# frozen_string_literal: true

require 'rspec'
require 'csv'
require './lib/invoice_item_repository'

describe InvoiceItemRepository do
  let(:iir) { InvoiceItemRepository.new(data) }
  describe '#initialize' do
    it 'instantiates with appropriate attributes' do
      expect(iir).to be_a InvoiceItemRepository
      expext(iir.repository).to eq([])
    end
  end
end
