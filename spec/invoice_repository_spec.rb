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

  it 'can find all invoices by customer id' do
    merchant_id = []
    @repo.find_all_by_customer_id(1).each do |invoice|
      merchant_id << invoice.merchant_id
    end

    expect(merchant_id).to eq([101, 103])

    expect(@repo.find_all_by_customer_id(200)).to eq([])
  end

  it 'can find all invoices by merchant id' do
    invoice_id = []
    @repo.find_all_by_merchant_id(101).each do |invoice|
      invoice_id << invoice.id
    end

    expect(invoice_id).to eq([1])

    expect(@repo.find_all_by_merchant_id(200)).to eq([])
  end

  it 'can find all invoices by merchant id' do
    invoice_id = []
    @repo.find_all_by_status(:pending).each do |invoice|
      invoice_id << invoice.id
    end
    expect(invoice_id).to eq([1])

    expect(@repo.find_all_by_status(:sent)).to eq([])
  end

  it 'creates the next highest merchant id' do
    expect(@repo.next_highest_id).to eq(4)
  end

  it 'can create a new invoice' do
    attributes = {
      :customer_id => 2,
      :merchant_id => 104,
      :status      => "pending"
    }

    @repo.create(attributes)

    updated_all = []
    @repo.all.each do |invoice|
      updated_all << invoice.id
    end

    expect(updated_all).to eq([1, 2, 3, 4])
  end

  it 'can only update status and nothing else' do
    attributes_1 = {status: :shipped}

    @repo.update(1, attributes_1)

    expect(@repo.find_by_id(1).status).to eq(:shipped)

    attributes_2 = {
      id: 50,
      customer_id: 22,
      merchant_id: 200,
      created_at: Time.now
    }

  end

  it 'can delete the merchant by id' do
      @repo.delete(2)

      updated_all = []
      @repo.all.each do |invoice|
        updated_all << invoice.merchant_id
      end
        expect(updated_all).to eq([101, 103])
  end

end
