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

  it 'can find an invoice by id' do
  expect(@repo.find_by_id(1).merchant_id).to eq(101)
  expect(@repo.find_by_id(200)).to eq(nil)
  expect(@repo.find_by_id(3).merchant_id).to eq(103)
  end

  xit 'can find all invoices by customer id' do
    expect(@repo.find_all_by_customer_id(1).id).to eq([1, 3])
    expect(@repo.find_all_by_customer_id(200)).to eq([])
  end

  it 'can find all invoices by merchant id' do
    expect(@repo.find_all_by_merchant_id(101).customer_id).to eq([1])
    expect(@repo.find_all_by_merchant_id(200)).to eq([])
  end



end
