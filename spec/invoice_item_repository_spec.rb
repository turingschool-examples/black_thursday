require_relative 'spec_helper'
require_relative '../lib/invoice_item_repository'
require_relative '../lib/invoice_item'

RSpec.describe InvoiceItemRepository do
  before (:each) do
    @repo = InvoiceItemRepository.new('./spec/fixtures/mock_invoice_items.csv')
  end

  it 'exists' do
    expect(@repo).to be_a(InvoiceItemRepository)
  end

  it 'returns all' do
    expect(@repo.all.length).to eq(3)
    @repo.all.each do |item|
      expect(item).to be_a(InvoiceItem)
    end
  end
end
