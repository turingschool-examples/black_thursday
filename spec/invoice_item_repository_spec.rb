require_relative 'spec_helper'
require_relative '../lib/invoice_item_repository'
require_relative '../lib/invoice_item'

RSpec.describe InvoiceItemRepository do
  before (:each) do
    @repo = InvoiceItemRepository.new('./spec/fixtures/mock_items.csv')
  end

  it 'exists' do
    expect(@repo).to be_a(InvoiceItemRepository)
  end
end
