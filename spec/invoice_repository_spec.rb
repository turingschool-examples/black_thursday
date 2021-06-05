require_relative 'spec_helper'
require_relative '../lib/invoice_repository'

RSpec.describe InvoiceRepository do
  before :each do
    @repo = InvoiceRepository.new('./spec/fixtures/mock_invoices.csv')
  end

  it 'exists' do
    expect(@repo).to be_an_instance_of(InvoiceRepository)
  end

  it 'returns all merchants' do
    expect(@repo.all_merchants.length).to eq(3)
  end

end 
