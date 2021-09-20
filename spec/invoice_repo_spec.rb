# frozen_string_literal: true

require 'csv'
require 'simplecov'
require './lib/sales_engine'
require './lib/invoice_repo'
require './lib/invoices'
SimpleCov.start

RSpec.describe do
  before(:each) do
    @engine = SalesEngine.from_csv({
                                     items: './data/items.csv',
                                     merchants: './data/merchants.csv',
                                     invoices: "./data/invoices.csv"
                                   })
  end

  it 'exists' do
    expect(@engine.invoices).to be_an_instance_of(InvoiceRepository)
  end

  it 'can list all invoices' do
    expect(@engine.invoices.all.length).to eq(4985)
  end

  it 'can return an invoice by id' do
    results = @engine.invoices.find_by_id(4648)

    expect(results.merchant_id).to eq(12335967)

    results2 = @engine.invoices.find_by_id(5000)
    expect(results2).to eq(nil)
  end

  it 'can find all by customer_id' do
    results = @engine.invoices.find_all_by_customer_id(1)

    expect(results.length).to eq(8)

    results2 = @engine.invoices.find_all_by_customer_id(0)
    expect(results2).to eq([])
  end

  it 'can find all by merchant_id' do
    results = @engine.invoices.find_all_by_merchant_id(12335955)

    expect(results.length).to eq(12)

    results2 = @engine.invoices.find_all_by_merchant_id(000000)
    expect(results2).to eq([])
  end

  it 'can find all by status' do
    results = @engine.invoices.find_all_by_status(:pending)

    expect(results.length).to eq(1473)

    results2 = @engine.invoices.find_all_by_status(:rejected)
    expect(results2).to eq([])
  end

  it 'can create a new invoice item' do
    attributes = {
      :customer_id => 7,
      :merchant_id => 8,
      :status      => "pending",
      :created_at  => Time.now,
      :updated_at  => Time.now,
                  }
    @engine.invoices.create(attributes)
    results = @engine.invoices.find_by_id(4986)
    expect(results.merchant_id).to eq(8)
  end

  it 'can update the invoices status' do
    attributes = {
      :customer_id => 7,
      :merchant_id => 8,
      :status      => "pending",
      :created_at  => Time.now,
      :updated_at  => Time.now,
                  }
    @engine.invoices.create(attributes)
    status_update = {
        status: :success
      }
    @engine.invoices.update(4986, status_update)
    expected = @engine.invoices.find_by_id(4986)
    expect(expected.status).to eq :success
    expect(expected.customer_id).to eq 7
  end

  it 'can delete a invoice by id' do
    @engine.invoices.delete(4985)

    expect(@engine.invoices.all.count).to eq(4984)
  end
end
