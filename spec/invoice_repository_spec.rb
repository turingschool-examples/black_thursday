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
    expect(@repo.all.length).to eq(3)
  end

  it 'can find a merchant by id' do
  expect(@repo.find_by_id(1).merchant_id).to eq(101)
  expect(@repo.find_by_id(200)).to eq(nil)
  expect(@repo.find_by_id(3).merchant_id).to eq(103)
  end

end
