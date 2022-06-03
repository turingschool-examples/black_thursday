require 'simplecov'
SimpleCov.start
require './lib/helper'

RSpec.describe InvoiceRepository do
  let!(:sales_engine) {SalesEngine.from_csv({:invoices => "./data/invoices.csv"})}
  let!(:invoice_repo) {sales_engine.invoices}

  it "exists" do
    expect(invoice_repo).to be_instance_of InvoiceRepository
  end

  it "can return all invoice instances in an array" do
    expect(invoice_repo.all).to be_a Array
  end
end
