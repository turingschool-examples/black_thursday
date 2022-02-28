require "./spec/spec_helper"
require "./lib/invoice_repo"
require "./lib/sales_engine"
require "./lib/invoice"
require "pry"

RSpec.describe InvoiceRepository do
  se = SalesEngine.from_csv({:invoices => "./data/invoices.csv"})
  invoice = se.invoices.find_by_id(3452)
  inv_r = InvoiceRepository.new(se.invoices_instanciator)

  it "is an instance of InvoiceRepository" do
    expect(inv_r).to be_an_instance_of(InvoiceRepository)
  end

  it "can return an array of all invoice instances" do
    expect(inv_r.all.length).to eq 4985
  end

  it "can find an invoice by id" do
    test_id = 3452
    expected_invoice = inv_r.find_by_id(test_id)
    expect(expected_invoice.invoice_attributes[:id]).to eq test_id
    # need merchant_id, customer_id, status
  end
end
